package cn.edu.hebtu.www.clubassembly.common.memcached;

import cn.edu.hebtu.www.clubassembly.utils.BaseUtils;
import net.rubyeye.xmemcached.GetsResponse;
import net.rubyeye.xmemcached.MemcachedClient;
import net.rubyeye.xmemcached.exception.MemcachedException;
import org.apache.log4j.Logger;

import java.util.*;
import java.util.concurrent.TimeoutException;

public class MemcacheStorage<T> {
    private MemcachedClient memcachedClient;
    private String prefix;
    private String className;
    private Decoder<T> decoder;
    private int time;
    private static final Logger logger = Logger.getLogger(MemcacheStorage.class);

    public MemcachedClient getMemcachedClient() {
        return memcachedClient;
    }

    public void setMemcachedClient(MemcachedClient memcachedClient) {
        this.memcachedClient = memcachedClient;
    }

    public String getPrefix() {
        return prefix;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    public int getTime() {
        return time;
    }

    public void setTime(int time) {
        this.time = time;
    }

    public Decoder<T> getDecoder() {
        return decoder;
    }

    public void setDecoder(Decoder<T> decoder) {
        this.decoder = decoder;
    }

    public T get(String id) {
        try {
            String key = prefix + "-" + id;
            String value = this.memcachedClient.get(key);
            logger.info("----------get memcached key is :" + key + ";   value is :" + value + "-----------------------");
            if (value == null) {
                return null;
            }
            return decoder.decode(value);
        } catch (TimeoutException e) {
            logger.warn(e);
        } catch (InterruptedException e) {
            logger.warn(e);
        } catch (MemcachedException e) {
            logger.warn(e);
        }
        return null;
    }

    public Map<String, T> multiGet(List<String> ids) {
        List<String> keys = new ArrayList<String>();
        Map<String, String> keysMap = new HashMap<String, String>();
        for (String id : ids) {
            if (id == null)
                continue;
            String key = prefix + "-" + id;
            keys.add(key);
            keysMap.put(key, id);
        }
        Map<String, T> result = new HashMap<String, T>();
        try {
            Map<String, GetsResponse<String>> responseMap = this.memcachedClient.gets(keys);
            if (responseMap == null || responseMap.entrySet() == null)
                return result;
            Iterator<Map.Entry<String, GetsResponse<String>>> iterator = responseMap.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<String, GetsResponse<String>> entry = iterator.next();
                String jsonString = entry.getValue().getValue();
                T value = decoder.decode(jsonString);
                String key = entry.getKey();
                result.put(keysMap.get(key), value);
            }
        } catch (TimeoutException e) {
            logger.warn(e);
        } catch (InterruptedException e) {
            logger.warn(e);
        } catch (MemcachedException e) {
            logger.warn(e);
        }
        return result;
    }

    public T add(String id, T value) {
        try {
            String key = prefix + "-" + id;
            logger.info("----------add memcached key is :" + key + "; value is :" + BaseUtils.gson.toJson(value) + "-----------------------");
            this.memcachedClient.set(key, time, BaseUtils.gson.toJson(value));
        } catch (TimeoutException e) {
            logger.warn(e);
        } catch (InterruptedException e) {
            logger.warn(e);
        } catch (MemcachedException e) {
            logger.warn(e);
        }
        return value;
    }

    public T add(String id, T value, int time) {
        try {
            String key = prefix + "-" + id;
            logger.info("----------add memcached key is :" + key + "; value is :" + BaseUtils.gson.toJson(value) + "-----------------------");
            this.memcachedClient.set(key, time, BaseUtils.gson.toJson(value));
        } catch (TimeoutException e) {
            logger.warn(e);
        } catch (InterruptedException e) {
            logger.warn(e);
        } catch (MemcachedException e) {
            logger.warn(e);
        }
        return value;
    }

    public void delete(String key) {
        try {
            this.memcachedClient.delete(prefix + "-" + key);
        } catch (TimeoutException e) {
            logger.warn(e);
        } catch (InterruptedException e) {
            logger.warn(e);
        } catch (MemcachedException e) {
            logger.warn(e);
        }
    }

    public void update(String id, T t) {
        try {
            this.memcachedClient.set(prefix + "-" + id, time, BaseUtils.gson.toJson(t));
        } catch (TimeoutException e) {
            logger.warn(e);
        } catch (InterruptedException e) {
            logger.warn(e);
        } catch (MemcachedException e) {
            logger.warn(e);
        }
    }

    public void update(String id, T oldT, T newT) {
        this.update(id, newT);
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public long incr(String id, long step) {
        try {
            return this.getMemcachedClient().incr(id, step, 0, 100, time);
        } catch (TimeoutException e) {
            logger.warn("incr timeout ", e);
        } catch (InterruptedException e) {
            logger.warn("interrupted", e);
        } catch (MemcachedException e) {
            logger.info("get value from mc failed", e);
        }
        return 0;
    }

    public long decr(String id, long step) {
        try {
            return this.getMemcachedClient().decr(id, step, 0, 100, time);
        } catch (TimeoutException e) {
            logger.warn("incr timeout ", e);
        } catch (InterruptedException e) {
            logger.warn("interrupted", e);
        } catch (MemcachedException e) {
            logger.info("get value from mc failed", e);
        }
        return 0;
    }
}
