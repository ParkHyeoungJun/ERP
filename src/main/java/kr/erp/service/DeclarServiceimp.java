package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.DeclarMapper;
import kr.erp.vo.Criteria;
import kr.erp.vo.DeclarVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
public class DeclarServiceimp implements DeclarService{
   @Setter(onMethod_ = @Autowired)   
   private DeclarMapper mapper;
   
   @Override
   public void add(DeclarVO vo) {
      // TODO Auto-generated method stub
      mapper.add(vo);
   }
   
   @Override
   public List<DeclarVO> select(Criteria cri) {
      // TODO Auto-generated method stub
      return mapper.select(cri);
   }

   @Override
   public DeclarVO read(Long idx) {
      // TODO Auto-generated method stub
      return mapper.read(idx);
   }

   @Override
   public int delete(Long idx) {
      // TODO Auto-generated method stub
      return mapper.delete(idx);
   }

   @Override
   public List<DeclarVO> Cselect(Criteria cri) {
      // TODO Auto-generated method stub
      return mapper.Cselect(cri);
   }
}