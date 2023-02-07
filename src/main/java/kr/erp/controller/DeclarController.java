package kr.erp.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.erp.vo.Sel;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/declar/*")
@AllArgsConstructor
public class DeclarController {

   @PostMapping(value = "/sel", produces = MediaType.APPLICATION_JSON_VALUE)
   public ResponseEntity<List<Sel>> sel() {
      List<Sel> list = new ArrayList<>();
      Sel s1 = new Sel("1","욕설");
      Sel s2 = new Sel("2","비방");
      Sel s3 = new Sel("3","광고");
      Sel s4 = new Sel("4","허위");
      Sel s5 = new Sel("5","음란물");
      Sel s6 = new Sel("6","기타사항");

      list.add(s1);
      list.add(s2);
      list.add(s3);
      list.add(s4);
      list.add(s5);
      list.add(s6);
      return new ResponseEntity<>(list, HttpStatus.OK);
   }

}