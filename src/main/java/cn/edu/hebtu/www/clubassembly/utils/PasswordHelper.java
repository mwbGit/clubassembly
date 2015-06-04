package cn.edu.hebtu.www.clubassembly.utils;

import cn.edu.hebtu.www.clubassembly.web.model.Admin;
import cn.edu.hebtu.www.clubassembly.web.model.Student;
import org.apache.log4j.Logger;
import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 对学生和管理员采用md5加盐的加密方式 。
 */
@Component
public class PasswordHelper {
    private Logger logger = Logger.getLogger(PasswordHelper.class);
    private RandomNumberGenerator randomNumberGenerator = new SecureRandomNumberGenerator();
    private String algorithmName = "md5";
    private int hashIterations = 2;


    public Student encryptStudentPassword(Student student) {
        //设置一个盐
        student.setSalt(randomNumberGenerator.nextBytes().toHex());
        //认证盐 = 用户名 + 盐.
        String credentialsSalt = student.getEmail() + student.getSalt();

        //新密码 = md5(认证盐 + 旧密码);
        String newPassword = new SimpleHash(
                algorithmName,
                student.getPassword(),
                ByteSource.Util.bytes(credentialsSalt),
                hashIterations).toHex();
        student.setPassword(newPassword);
        return student;
    }



    public boolean authenticationStudentPassword(String inputPassword, Student student) {
        //认证盐 = 用户名 + 盐.
        String credentialsSalt = student.getEmail() + student.getSalt();

        //新密码 = md5(认证盐 + 旧密码);
        String newPassword = new SimpleHash(
                algorithmName,
                inputPassword,
                ByteSource.Util.bytes(credentialsSalt),
                hashIterations).toHex();
        logger.info("db password:" + student.getPassword());
        logger.info("input password:" + student.getPassword());

        if (newPassword.equals(student.getPassword())) {
            return true;
        } else {
            return false;
        }
    }

    //    生产邮件内容
    public String generateContent(Student student) {
//        邮件内容中会一个地址，是为激活密钥
        String token = student.getEmail() + "--" + BaseUtils.DateToString(student.getRegisterTime());
        String encryptToken = DESEncrypt.encrypt(token, Constant.TOKENKEY);
        String url = "http://localhost:8080/clubassembly/active?token=" + encryptToken;
        logger.info(url);
        return "<a href='" + url + "'>点此激活</a>";
    }

    public String parseEmailFromToken(String token) {
        try {
            String origin = DESEncrypt.parse(token, Constant.TOKENKEY);
            logger.info("origin:" + origin);
            String[] temp = origin.split("--");
            return temp[0];
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Date parseRegisterDateFromToken(String token) {
        try {
            String origin = DESEncrypt.parse(token, Constant.TOKENKEY);
            logger.info("origin:" + origin);
            String[] temp = origin.split("--");
            logger.info("date:" + BaseUtils.StringToDate(temp[1]));
            return BaseUtils.StringToDate(temp[1]);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public Admin encryptAdminPassword(Admin admin) {
        //设置一个盐
        admin.setSalt(randomNumberGenerator.nextBytes().toHex());
        //认证盐 = 用户名 + 盐.
        String credentialsSalt = admin.getEmail() + admin.getSalt();

        //新密码 = md5(认证盐 + 旧密码);
        String newPassword = new SimpleHash(
                algorithmName,
                admin.getPassword(),
                ByteSource.Util.bytes(credentialsSalt),
                hashIterations).toHex();
        admin.setPassword(newPassword);
        return admin;
    }

    public boolean authenticationAdminPassword(String inputPassword, Admin admin) {
        //认证盐 = 用户名 + 盐.
        String credentialsSalt = admin.getEmail() + admin.getSalt();

        //新密码 = md5(认证盐 + 旧密码);
        String newPassword = new SimpleHash(
                algorithmName,
                inputPassword,
                ByteSource.Util.bytes(credentialsSalt),
                hashIterations).toHex();
        logger.info("db password:" + admin.getPassword());
        logger.info("input password:" + admin.getPassword());

        if (newPassword.equals(admin.getPassword())) {
            return true;
        } else {
            return false;
        }
    }



}
