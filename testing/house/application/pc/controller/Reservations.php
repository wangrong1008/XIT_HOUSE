<?php
/**
 * 关注房源
 */

namespace app\pc\controller;

use think\Controller;
use \think\Request;
use app\pc\model\Reservations as ReservationsModel;
use app\pc\model\SellingHouse as SellingHouseModel;
use app\pc\model\SellingHouseImg as SellingHouseImgModel;
use app\pc\model\User as UserModel;

class Reservations extends BaseController
{
    /**
     * 关注的房源
     * @return mixed
     */
    public function index()
    {
        //标题
        $this->assign('title', '预约看房');
        //创建reservations的model实例
        $reservations = new ReservationsModel;
        //创建house的model实例
        $house = new SellingHouseModel;
        //创建house_img的model实例
        $houseImg = new SellingHouseImgModel;
        //通过$_SESSION获取用户id
        $user_id = session('user')['id'];
        //获取关注房源列表，分页每4条一页
        $reservationsList = $reservations->where(['user_id' => $user_id])->paginate(4);
        foreach ($reservationsList as &$v) {
            $v['info'] = $house->where(['id' => $v['house_id']])->find();
            $v['info']['img'] = $houseImg->where(['selling_house_id' => $v['house_id']])->find()['filename'];
        }
        //定义attentionList的模板变量，传输到模板视图中

        $this->assign('reservationsList', $reservationsList);

        //创建user的model实例
        $user = new UserModel();
        //获取用户基本信息
        $data = $user->findById($user_id);
        //定义data模板变量，传输到模板视图中
        $this->assign('data', $data);

        // 返回当前控制器对应的视图模板index.html
        return $this->fetch();
    }


}
