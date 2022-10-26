import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@RunWith(SpringJUnit4ClassRunner.class)
@Slf4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class JDBCTests {
    @Setter(onMethod_ = {@Autowired})
    private DataSource dataSource;
    @Setter(onMethod_ = {@Autowired}) private SqlSessionFactory sqlSessionFactory;
    @Test
    public void testConnection(){
        try(SqlSession sqlSession = sqlSessionFactory.openSession(); Connection con = sqlSession.getConnection();){
            log.info(sqlSession.toString());
            log.info(con.toString());
        }catch (SQLException e){
            log.error(e.getMessage());
        }
    }
}
