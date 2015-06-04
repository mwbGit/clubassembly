package cn.edu.hebtu.www.clubassembly.utils;

import org.apache.log4j.Logger;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import java.security.SecureRandom;

/**
 * DES加密.
 */
public class DESEncrypt {
    // 添加打印日志
    private static final Logger logger = Logger.getLogger(DESEncrypt.class);

    public static String encrypt(String str, String key) {
        try {
            SecureRandom random = new SecureRandom();
            DESKeySpec desKey = new DESKeySpec(key.getBytes());
            //创建一个密匙工厂，然后用它把DESKeySpec转换成
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            SecretKey securekey = keyFactory.generateSecret(desKey);
            //Cipher对象实际完成加密操作
            Cipher cipher = Cipher.getInstance("DES");
            //用密匙初始化Cipher对象
            cipher.init(Cipher.ENCRYPT_MODE, securekey, random);
            //现在，获取数据并加密
            //正式执行加密操作
            byte[] result = cipher.doFinal(str.getBytes());
            String test = "";
            for (int i = 0; i < result.length; i++) {
                // System.out.print(result[i] + ",");
                test = test + String.valueOf(result[i]) + ",";
            }
            return test.substring(0, test.length() - 1);
        } catch (Throwable e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String parse(String strsrc, String key) throws Exception {
        String[] back = strsrc.split(",");
        byte[] parse = new byte[back.length];
        for (int i = 0; i < back.length; i++) {
            // System.out.print(back[i] + "*");
            parse[i] = Byte.valueOf(back[i]);
            // System.out.print(parse[i] + "&");
        }
        // DES算法要求有一个可信任的随机数源
        SecureRandom random = new SecureRandom();
        // 创建一个DESKeySpec对象
        DESKeySpec desKey = new DESKeySpec(key.getBytes());
        // 创建一个密匙工厂
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        // 将DESKeySpec对象转换成SecretKey对象
        SecretKey securekey = keyFactory.generateSecret(desKey);
        // Cipher对象实际完成解密操作
        Cipher cipher = Cipher.getInstance("DES");
        // 用密匙初始化Cipher对象
        cipher.init(Cipher.DECRYPT_MODE, securekey, random);
        // 真正开始解密操作
        byte[] hhel = cipher.doFinal(parse);
        //logger.info(hhel.length);
        String result = new String(hhel);
       // logger.info(result);
        return result;
    }
}
