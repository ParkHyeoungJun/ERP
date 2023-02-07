package kr.erp.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Sel {
   private String code;
   private String name;
   
   public Sel(String code,String name) {
      this.code = code;
      this.name = name;
   }
}