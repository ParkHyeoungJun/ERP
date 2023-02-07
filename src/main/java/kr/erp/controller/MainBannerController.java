package kr.erp.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.URLDecoder;
import java.net.UnknownHostException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.erp.service.MainBannerService;
import kr.erp.util.UploadFileUtils;
import kr.erp.vo.MainBannerVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/admin/mainbanner/*")
@Controller
@Log4j
@AllArgsConstructor
public class MainBannerController {
	private MainBannerService service;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@GetMapping("/list")
	public void list() {

	}
	
	@GetMapping("/add")
	public void add() {

	}
	
	@PostMapping(value = "/select", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MainBannerVO>> select() {
		
		return new ResponseEntity<>(service.select(), HttpStatus.OK);
	}
	
	@PostMapping("/add")
	public ResponseEntity<String> addajax(MainBannerVO vo, MultipartFile file, Model model) throws Exception {
		InetAddress local = null;
		try {
			local = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String ip = local.getHostAddress();
		vo.setIp(ip);
		
		log.info(ToStringBuilder.reflectionToString(vo));
		
		//썸네일
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		
		if(file != null) {
		 fileName =  UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
		} else {
		 fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		vo.setImage(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		vo.setSimg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		
		
		service.add(vo);

		return new ResponseEntity<String>("succuess", HttpStatus.OK);
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public ResponseEntity<String> delete(@RequestParam String filename, Long idx, Model model) {
		log.info("deleteFile: " + filename);
		File file;
		try {

			filename = URLDecoder.decode(filename, "UTF-8");
			file = new File(
					"C:\\Project\\STS\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\ERP\\resources"
							+ filename);

			filename = filename.substring(filename.indexOf("/") + 1, filename.indexOf("_"));
			log.info("uuid: " + filename);

			int row = service.delete(idx);

			file.delete();

			if (row > 0) {
				return new ResponseEntity<String>("succuess", HttpStatus.OK);
			} else {
				return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
			// 파일 삭제.
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

	}
	
}