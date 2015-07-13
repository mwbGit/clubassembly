package cn.edu.hebtu.www.clubassembly.common.memcached;

/**
 * Created by fanngyuan on 12/24/14.
 */
public interface Decoder<T>{

    public T decode(String value);

}
