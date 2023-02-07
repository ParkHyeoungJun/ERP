package kr.erp.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.erp.service.DocService;
import kr.erp.vo.DocVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin/doc*")
@AllArgsConstructor
public class AdminDocController {
  private DocService serivce;
	@GetMapping("/select")
	public void select() {

	}
	
	@GetMapping("/projectselect")
	public void projectselect() {

	}
	
	/*
	 * 입력 혹은 수정 
	 * */
	@PostMapping("add")
	public ResponseEntity<String> add(DocVO vo)
	{
		log.info("입력 혹은 수정 기획");
		if(vo.getNum()==null || vo.getNum()==0)
		{
			serivce.add(vo);
		}
		else 
		{
			serivce.modfiy(vo);
		}	
		return new ResponseEntity<String>("succuess", HttpStatus.OK);		
	}
	
	/*
	 * 삭제 하기전 파일 타입이라면 파일을 서버에서 삭제 처리 
	 * */
	@PostMapping("delete")
	public ResponseEntity<String> delete(Long idx)
	{
		DocVO vo = serivce.get(idx);
		File file;
		String filename ;
		int row=0;
		if(vo!=null)
		{
			// 파일 형식이라면 실제 서버에 파일 삭제 
			if(vo.getFiletype()=="file")
			{
				filename = vo.getUuid();
				try {
					filename = URLDecoder.decode(filename, "UTF-8");
					file = new File("c:\\upload\\" + filename);
					file.delete();
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}				
			}
			row= serivce.delete(idx);
		}
		if(row>0)
		{
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		}
		else
		{
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
		}
		
	}
	
	/*단일 건 
	 * */
	@PostMapping(value = "/get", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<DocVO> get (Long idx)
	{
		return new ResponseEntity<DocVO>(serivce.get(idx), HttpStatus.OK);		
	}
	
	
	
}
