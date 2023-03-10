package kr.erp.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller

public class CommonController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Resource
	private String uploadPath;

	@RequestMapping(value = "/common/ckUpload", method = RequestMethod.POST)
	@ResponseBody
	public void ckUpload(HttpServletRequest req, HttpServletResponse res, @RequestParam MultipartFile upload)
			throws Exception {
		logger.info("ckUpload 진입 =========================================1");
		// 랜덤 문자 생성
		UUID uid = UUID.randomUUID();
		OutputStream out = null;
		PrintWriter printWriter = null; // 인코딩
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html;charset=utf-8");
		try {
			String fileName = upload.getOriginalFilename(); // 파일
			// 이름 가져오기
			byte[] bytes = upload.getBytes();
			// 업로드 경로
			String ckUploadPath = uploadPath + File.separator + "ckUpload" + File.separator + uid + "_" + fileName;
			out = new FileOutputStream(new File(ckUploadPath));
			out.write(bytes);
			out.flush(); // out에 저장된 데이터를 전송하고 초기화
			String callback = req.getParameter("CKEditorFuncNum");
			printWriter = res.getWriter();
			String fileUrl = "/ckUpload/" + uid + "_" + fileName; // 작성화면 //
			// String fileUrl = "/ckUpload/" + uid + "&fileName=" + fileName; // 작성화면
			// 업로드시 메시지 출력
			printWriter.println("{\"filename\" : \"" + fileName + "\", \"uploaded\" : 1, \"url\":\"" + fileUrl + "\"}");
			printWriter.flush();
		} catch (IOException e) {
			logger.info("error:"+e.getMessage());
			// e.printStackTrace();
		}
	}

}