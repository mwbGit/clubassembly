package cn.edu.hebtu.www.clubassembly.common.memcached;

import cn.edu.hebtu.www.clubassembly.utils.BaseUtils;
import org.apache.log4j.Logger;


/**
 * json解码对象
 *
 * @param <T>
 */
public class JsonDecoder<T> implements Decoder {

    private static final Logger logger = Logger.getLogger(JsonDecoder.class);

    private Class<T> clazz;

    private String className;

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
        try {
            this.clazz = (Class<T>) Class.forName(className);
        } catch (ClassNotFoundException e) {
            logger.warn(e);
        }
    }

    @Override
    public T decode(String value) {
        return BaseUtils.gson.fromJson(value, clazz);
    }
}
