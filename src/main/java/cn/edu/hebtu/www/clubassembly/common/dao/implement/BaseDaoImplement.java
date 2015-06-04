package cn.edu.hebtu.www.clubassembly.common.dao.implement;

import cn.edu.hebtu.www.clubassembly.common.dao.BaseDaoI;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;
import java.util.Map;


@SuppressWarnings("unchecked")
@Repository("BaseDao")
public class BaseDaoImplement<T> implements BaseDaoI<T> {


    private SessionFactory sessionFactory;

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    @Resource(name = "sessionFactory")
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    //
    private Session getCurrentSession() {
        return this.sessionFactory.getCurrentSession();
    }

    /**
     * 保存一个对象
     *
     * @param o 要保存的对象
     * @return
     */

    @Override
    public Serializable save(T o) {
        return this.getCurrentSession().save(o);
    }

    /**
     * 删除一个对象
     *
     * @param o 要删除的对象
     */
    @Override
    public void delete(T o) {
        this.getCurrentSession().delete(o);
    }

    /**
     * 修改一个对象
     *
     * @param o 要修改的对象
     */
    @Override
    public void update(T o) {
        this.getCurrentSession().clear();
        this.getCurrentSession().update(o);
    }

    /**
     * 保存或更新一个对象，如果这个对象在，就更新，如果不在，就保存
     *
     * @param o 保存或更新一个对象
     */
    @Override
    public void saveOrUpdate(T o) {
        this.getCurrentSession().saveOrUpdate(o);
    }

    /**
     * 得到一个对象，通过查询语句
     *
     * @param hql 查询语句
     * @return 查询得到的记录的第一条记录
     */
    @Override
    public T get(String hql) {
        Query q = this.getCurrentSession().createQuery(hql);
        List<T> list = q.list();
        if (list != null & list.size() > 0) {
            return list.get(0);
        } else {
            return null;
        }
    }

    /**
     * 得到一个对象，附加查询参数（MAP<string,object></>）
     *
     * @param hql    查询语句
     * @param params 查询参数
     * @return
     */
    @Override
    public T get(String hql, Map<String, Object> params) {

        // 构造查询
        Query q = this.getCurrentSession().createQuery(hql);

        // 有参数的话
        if (params != null && !params.isEmpty()) {
            for (String key : params.keySet()) {
                // 给查询添加参数
                q.setParameter(key, params.get(key));
            }
        }

        // 得到查询列表
        List<T> l = q.list();
        if (l != null && l.size() > 0) {
            // 返回得到的查询列表的第一条记录
            return l.get(0);
        }
        return null;
    }

    /**
     * 查找多条记录
     *
     * @param hql 查询语句
     * @return 查询结果, 列表，可能为空
     */
    @Override
    public List<T> find(String hql) {
        Query q = this.getCurrentSession().createQuery(hql);
        // 可能为空
        return q.list();
    }

    /**
     * 通过参数查找多条记录，
     *
     * @param hql
     * @param params
     * @return
     */
    @Override
    public List<T> find(String hql, Map<String, Object> params) {
        // 构造查询
        Query q = this.getCurrentSession().createQuery(hql);

        // 查询有参数
        if (params != null & params.size() > 0) {
            // 遍历map的键。
            for (String key : params.keySet()) {
                // 给查询添加参数
                q.setParameter(key, params.get(key));
            }
        }
        return q.list();
    }

    /**
     * 分页查询数据
     *
     * @param hql
     * @param page 第几页
     * @param rows 查询多少行
     * @return
     */
    @Override
    public List<T> find(String hql, int page, int rows) {
        Query q = this.getCurrentSession().createQuery(hql);
        // 按第几页，查询多少行，查询数据。
        return q.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
    }

    /**
     * 分页查询数据，带参数
     *
     * @param hql
     * @param params
     * @param page
     * @param rows
     * @return
     */
    @Override
    public List<T> find(String hql, Map<String, Object> params, int page, int rows) {
        Query q = this.getCurrentSession().createQuery(hql);
        if (params != null && !params.isEmpty()) {
            for (String key : params.keySet()) {
                q.setParameter(key, params.get(key));
            }
        }
        return q.setFirstResult((page - 1) * rows).setMaxResults(rows).list();
    }

    /**
     * 得到查询的记录数，
     *
     * @param hql
     * @return
     */
    @Override
    public Long count(String hql) {
        Query q = this.getCurrentSession().createQuery(hql);
        return (Long) q.uniqueResult();
    }

    /**
     * 得到查询的记录数,带参数
     *
     * @param hql
     * @param params
     * @return
     */
    @Override
    public Long count(String hql, Map<String, Object> params) {
        Query q = this.getCurrentSession().createQuery(hql);
        if (params != null && !params.isEmpty()) {
            for (String key : params.keySet()) {
                q.setParameter(key, params.get(key));
            }
        }
        return (Long) q.uniqueResult();
    }

    @Override
    public int executeHql(String hql) {
        Query q = this.getCurrentSession().createQuery(hql);
        return q.executeUpdate();
    }

}
