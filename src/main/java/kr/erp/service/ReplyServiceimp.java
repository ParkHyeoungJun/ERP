package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.erp.mapper.AttachMapper;
import kr.erp.mapper.BoardMapper;
import kr.erp.mapper.ReplyMapper;
import kr.erp.vo.ReplyVO;
import lombok.Setter;
@Service
public class ReplyServiceimp implements ReplyService {
   @Setter(onMethod_ = @Autowired)   
   private ReplyMapper mapper;
   @Setter(onMethod_ = @Autowired)
   private BoardMapper boardmapper;
   @Setter(onMethod_ = @Autowired)
   private ReplyMapper replymapper;
   @Setter(onMethod_ = @Autowired)
   private AttachMapper attachmapper;
   
   
   @Transactional
   @Override   
   public int add(ReplyVO vo) {
      boardmapper.updateReplyCnt(vo.getNum(),1);
      return mapper.add(vo);      
   }

   @Override
   public int modfiy(ReplyVO vo) {
      // TODO Auto-generated method stub
      return mapper.modfiy(vo);
   }

   @Override
   public int delete(Long idx) {
      // TODO Auto-generated method stub
      ReplyVO vo = mapper.idx(idx);
      boardmapper.updateReplyCnt(vo.getNum(), -1);
      
      return mapper.delete(idx);
   }

   @Override
   public List<ReplyVO> select(Long num) {
      // TODO Auto-generated method stub
      return mapper.select(num);
   }

}
