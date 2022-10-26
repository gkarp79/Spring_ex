import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;
import org.bo.domain.BoardVO;
import org.bo.domain.Criteria;
import org.bo.mapper.BoardMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class BoardMapperTests {
    @Setter(onMethod_ = @Autowired) private BoardMapper mapper;

    @Test
    public void testGetList(){
        mapper.getList().forEach(board -> log.info(board.toString()));
    }
    @Test
    public void testInsert(){
        BoardVO board = new BoardVO();
        board.setTitle("새로 작성하는 글");
        board.setContent("새로 작성하는 내용");
        board.setWriter("newid");

        mapper.insert(board);
        log.info(board.toString());
        mapper.getList().forEach(boards -> log.info(boards.toString()));
    }

    @Test
    public void testInsertKey(){
        BoardVO board = new BoardVO();
        board.setTitle("새로 작성하는 글");
        board.setContent("새로 작성하는 내용");
        board.setWriter("newid");

        mapper.insertSelectKey(board);
        log.info(board.toString());
        mapper.getList().forEach(boards -> log.info(boards.toString()));
    }
    @Test
    public void testRead(){
        BoardVO board = mapper.read(5L);
        log.info(board.toString());
    }

    @Test
    public void testDelete(){
        log.info("DELETE COUNT : " + mapper.delete(5L));

    }

    @Test
    public void testUpdate(){
        BoardVO board = new BoardVO();
        board.setBno(4L);
        board.setTitle("수정된 글");
        board.setContent("수정된 내용");
        board.setWriter("user00");
        log.info("UPDATE COUNT : " + mapper.update(board));
    }

    @Test
    public void testPaging(){
        Criteria cri = new Criteria();
        cri.setPageNum(3);
        cri.setAmount(10);
        List<BoardVO> list = mapper.getListWithPaging(cri);
        list.forEach(board -> log.info(board.getBno()));
    }

    @Test
    public void testSearch(){
        Criteria cri = new Criteria();
        cri.setKeyword("새로");
        cri.setType("TC");
        List<BoardVO> list = mapper.getListWithPaging(cri);
        list.forEach(board -> log.info(board));
    }


}
