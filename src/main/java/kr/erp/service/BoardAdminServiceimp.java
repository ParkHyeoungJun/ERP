package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.BoardAdminMapper;
import kr.erp.vo.BoardAdminVO;
import lombok.Setter;
@Service
public class BoardAdminServiceimp implements BoardAdminService{
   @Setter(onMethod_ = @Autowired)   
   private BoardAdminMapper mapper;
   @Override
   public void add(BoardAdminVO vo) {
      // TODO Auto-generated method stub
       mapper.add(vo);
   }

   @Override
   public List<BoardAdminVO> select() {
      // TODO Auto-generated method stub
      return mapper.select();
   }

   @Override
   public int update(BoardAdminVO vo) {
      // TODO Auto-generated method stub
      return mapper.update(vo);
   }

   @Override
   public int delete(Long code) {
      // TODO Auto-generated method stub
      return mapper.delete(code);
   }

   @Override
   public BoardAdminVO get(Long code) {
      // TODO Auto-generated method stub
      return mapper.get(code);
   }

}