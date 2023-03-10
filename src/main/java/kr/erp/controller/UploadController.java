package kr.erp.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.erp.mapper.AttachMapper;
import kr.erp.vo.AttachVO;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
public class UploadController {
	String uploadFolder = "c:\\upload";

	@Setter(onMethod_ = @Autowired)
	private AttachMapper attachMapper;

	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody // 응답을 json 형태로 리턴.
	public ResponseEntity<List<AttachVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		// rest 방식 으로 ajax 처리
		// 파일을 받고 json 값을 리턴.

		List<AttachVO> list = new ArrayList<>();
		// 여러개 파일 저장을 위한 객체 배열 타입 선언.
		String uploadFolder = "c:\\upload";

		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		// 예) c:\\upload\\2021\\10\\12 에 파일 저장 예정.

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
			// 경로에 폴더들이 생성되어 있지 않다면, 폴더 생성.
		}

		// 파일은 1개 일수도 있고, 여러개 일수도 있음.
		for (MultipartFile multipartFile : uploadFile) {
			AttachVO attachDTO = new AttachVO();
			String uploadFileName = multipartFile.getOriginalFilename();
			// 파일의 원래 이름 저장.
			//log.info("uploadFileName.getOriginalFilename:" + uploadFileName);

			// 익스플로러용 처리.(\\ 이후의 파일명과 확장자 가져오기)
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			// chrome 경우,
			// getOriginalFilename:1012.txt
			// substring:1012.txt

			// explorer 경우,
			// getOriginalFilename:C:\\Users\\user\\Documents\\1012.txt
			// substring:1012.txt
			// getOriginalFilename 메소드로 얻어진 값에서 문자열 재가공.
			//log.info("uploadFileName.substring:" + uploadFileName);

			// attachDTO.setFileName(uploadFileName);
			attachDTO.setFilename(uploadFileName);
			// 파일 이름 저장.

			UUID uuid = UUID.randomUUID();
			// universal unique identifier, 범용 고유 식별자.
			// 파일의 중복을 회피.

			uploadFileName = uuid.toString() + "_" + uploadFileName;
			// 예) uuid_일일일.txt

			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				// 서버에 파일 저장.

				InetAddress local = null;
				try {
					local = InetAddress.getLocalHost();
				} catch (UnknownHostException e) {
					log.info("error1111:"+e.getMessage());
				}
				String ip = local.getHostAddress();
				attachDTO.setIp(ip);
				log.info("url:"+uploadFolderPath+"\\"+uploadFileName);
				attachDTO.setUuid(uploadFolderPath+"\\"+uploadFileName);
				// attachDTO.setUploadPath(uploadFolderPath);
				attachDTO.setUploadpath(uploadFolderPath);
				list.add(attachDTO);
				// 업로드된 파일 정보를 객체 배열에 담아서 리턴.
			} catch (Exception e) {
				log.info("error2222:"+e.getMessage());
				//e.printStackTrace();
			}
		}

		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
		// 파일 검색 시간을 줄이기 위해서,
		// 폴더 1개에 모두 저장하는 것이 아니라,
		// 년월일로 구분하여 폴더를 생성하고 그곳에 파일을 저장.
		// File.separator : 폴더 구분자를 운영체제에 맞춰서 변경.
		// 2021-04-28
		// 2021/04/28 결과적으로 날짜별로 파일 저장.

	}

	@PostMapping("/deleteFile")
	//@ResponseBody
	public ResponseEntity<String> deleteFile(AttachVO vo) {
		String filename ="";
		log.info("deleteFile: " + vo.getUuid());
		File file;
		try {
			// AttachVO vo=attachMapper.get(idx);
			vo.setUuid(URLDecoder.decode(vo.getUuid(), "UTF-8")); 
			file = new File("c:\\upload\\" + vo.getUuid());
			// 한글의 경우, 페이지 전환시 변경됨.
			// 알맞는 문자 포맷으로 해석해서 읽어 들여야 함.
			// c:\\upload\\2021\\10\\13\\uuid_filename.ext

			//filename = filename.substring(filename.indexOf("/") + 1, filename.indexOf("_"));
			log.info("uuid: " + filename);
			// 디비에서 삭제를 선택한 파일 정보 삭제.
			attachMapper.delete(vo);

			file.delete();
			// 파일 삭제.
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);
		// return null;
	}

	// 모든 파일은 내부적으로 bit 값을 가짐.(문서, 영상, 이미지, 소리)
	// 비트 스트림을 재조합하여 파일로 구성.
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		// 서버에 접속한 브라우저의 정보는
		// 헤더의 User-Agent를 보면 알 수 있음.

		// import org.springframework.core.io.Resource;
		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
		// 파일을 리소스(자원: 가공 처리를 위한 중간 단계)로 변경.
		log.info("resource: " + resource);

		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		String resourceName = resource.getFilename();
		// 리소스에서 파일명을 찾아서 할당.

		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		// uuid 를 제외한 파일명 만들기.

		// import org.springframework.http.HttpHeaders;
		HttpHeaders headers = new HttpHeaders();

		// 웹 브라우저별 특성 처리 (한글 변환)
		try {
			String downloadName = null;

			if (userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\", " ");
			} else if (userAgent.contains("Edge")) {
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			} else {
				log.info("chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			log.info("downloadName: " + downloadName);
			headers.add("Content-disposition", "attachment; filename=" + downloadName);
			// 헤더에 파일 다운로드 정보 추가.

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

	@PostMapping(value = "/fileselect", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AttachVO>> fileselect(@RequestParam Long num) {
		return new ResponseEntity<List<AttachVO>>(attachMapper.select(num), HttpStatus.OK);
	}

	
	

}
