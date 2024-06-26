package com.hui.utils;

import java.io.Serializable;

public class PageResult<T> implements Serializable {

    private static final long serialVersionUID = 3565804123150766799L;
    private int pageNo;         //当前页数
    private int pageSize;       //每页展示条数
    private int total;          //总条数
    private int totalPage;      //总页数
    private T result;           //结果

    public PageResult() {}

    public PageResult(int pageNo, int pageSize, int total, T result) {
        this.pageNo = pageNo == 0 ? 1 : pageNo;
        this.pageSize = pageSize;
        this.total = total;
        if (total > 0 ) {
            this.totalPage = total % pageSize > 0 ? (total / pageSize) + 1 : total / pageSize;
        }
        this.result = result;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public T getResult() {
        return result;
    }

    public void setResult(T result) {
        this.result = result;
    }
}


