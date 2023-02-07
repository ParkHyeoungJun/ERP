package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.ScheduleMapper;
import kr.erp.vo.Criteria;
import kr.erp.vo.ScheduleVO;
import lombok.Setter;

@Service
public class ScheduleServiceimp implements ScheduleService{
   @Setter(onMethod_ = @Autowired)
   private ScheduleMapper mapper;
   
   @Override
   public void add(ScheduleVO vo) {
      // TODO Auto-generated method stub
      mapper.add(vo);
   }

   @Override
   public List<ScheduleVO> select(Criteria cri) {
      // TODO Auto-generated method stub
      return mapper.select(cri);
   }

   @Override
   public ScheduleVO get(Long num) {
      // TODO Auto-generated method stub
      return mapper.get(num);
   }

   @Override
   public int delete(Long num) {
      // TODO Auto-generated method stub
      return mapper.delete(num);
   }

   @Override
   public void update(ScheduleVO vo) {
      // TODO Auto-generated method stub
      mapper.update(vo);
   }
   
   @Override
   public List<ScheduleVO> calendar() {
   	// TODO Auto-generated method stub
   	return mapper.calendar();
   }

}