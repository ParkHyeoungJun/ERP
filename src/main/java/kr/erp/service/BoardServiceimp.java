package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.erp.mapper.AttachMapper;
import kr.erp.mapper.BoardMapper;
import kr.erp.mapper.ReplyMapper;
import kr.erp.vo.BoardVO;
import kr.erp.vo.Criteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceimp implements BoardService {
   @Setter(onMethod_ = @Autowired)
   private BoardMapper mapper;
   
   @Setter(onMethod_ = @Autowired)
   private AttachMapper attachmapper;
   
   @Setter(onMethod_ = @Autowired)
   private ReplyMapper replymapper;
   
   @Transactional
   @Override
   public void add(BoardVO vo) {
      // TODO Auto-generated method stub
      mapper.insertSelectKey(vo);
      if (vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
         // 첨부파일이 없다면 종료.
         return;
      }
     log.info("count:"+vo.getAttachList().size());
      vo.getAttachList().forEach(attach -> {
         attach.setNum(vo.getNum());
         attach.setWriter(vo.getWriter());
         // BoardAttachVO 의 객체 attach
         attachmapper.add(attach);
      });
   }

   @Override
   public List<BoardVO> select(Criteria cri) {
      // TODO Auto-generated method stub
      return mapper.select(cri);
   }

   @Override
   public int clientupdate(BoardVO vo) {
      // TODO Auto-generated method stub
      int cnt= mapper.clientupdate(vo);
      
      if (vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
          // 첨부파일이 없다면 종료.
          return 0;
       }

       vo.getAttachList().forEach(attach -> {
          attach.setNum(vo.getNum());
          attach.setWriter(vo.getWriter());
          // BoardAttachVO 의 객체 attach
          attachmapper.add(attach);
       });
	return cnt;
   }

   @Override
   public int delete(Long num) {
      // TODO Auto-generated method stub
      attachmapper.deleteAll(num);
      replymapper.deleteAll(num);
      
      return mapper.delete(num);
   }


   @Override
   public BoardVO get(Long num) {
      // TODO Auto-generated method stub
      return mapper.get(num);
   }

   @Override
   public int update(BoardVO vo) {
      // TODO Auto-generated method stub
      int row = mapper.update(vo);
      if (vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
         // 첨부파일이 없다면 종료.
         return row;
      }

      vo.getAttachList().forEach(attach -> {
         attach.setNum(vo.getNum());
         attach.setWriter(vo.getWriter());
         // BoardAttachVO 의 객체 attach
         attachmapper.add(attach);
      });
      
      return row;
   }

   @SuppressWarnings("restriction")
   @Transactional
   @Override
   public void insertSelectKey(BoardVO vo) {
      // TODO Auto-generated method stub
       mapper.insertSelectKey(vo);
       log.info("1902 파일 업로드");
      if (vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
         // 첨부파일이 없다면 종료.
         return;
      }

      vo.getAttachList().forEach(attach -> {
         attach.setNum(vo.getNum());
         attach.setWriter(vo.getWriter());
         // BoardAttachVO 의 객체 attach
         attachmapper.add(attach);
      });
   }

   
   public List<BoardVO> myselect(Criteria cri) {
      // TODO Auto-generated method stub
      return mapper.myselect(cri);
   }
}