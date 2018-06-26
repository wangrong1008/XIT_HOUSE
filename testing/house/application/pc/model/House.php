<?php
/**
 * table:house
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/12/24
 * Time: 21:02
 */

namespace app\pc\model;

use think\Model;

class House extends Model
{
    //供暖方式
    public function getHeatingMethodAttr($value)
    {
        $data = [0=>'暂无数据',1=>'自供暖',2=>'集体供暖'];
        return $data[$value];
    }

    public function admin1(){
        return $this->hasOne('admin','id','admin_id');
    }
    //方式
    public function getWayAttr($value)
    {
        $data = [0=>'暂无数据',1=>'整租',2=>'合租'];
        return $data[$value];
    }

    //所在楼层
    public function getFloorAttr($value)
    {
        $data = [0=>'无',1=>'底层',2=>'低楼层',3=>'中楼层',4=>'高楼层',5=>'顶层'];
        return $data[$value];
    }
    //装修情况
    public function getDecorationAttr($value)
    {
        $data = [0=>'无',1=>'精装',2=>'普装',3=>'毛坯房'];
        return $data[$value];
    }
    //获取信息--多条
    public function getList($where=array(),$order="id desc",$limit=""){
        return $this->where($where)->order($order)->limit($limit)->select();
    }
    //通过主键id获取一条数据
    public function findById($id){
        return $this->where(['id'=>$id])->find();
    }


    //通过主键id删除数据
    public function deleteById($id){
        return $this->where(['id'=>$id])->delete();
    }

    //插入数据
    public function addData($data){
        return $this->isUpdate(false)->data($data, true)->save();
    }

    //更新数据
    public function updateData($data,$where){
        $this->isUpdate(true)->save($data,$where);
    }



}