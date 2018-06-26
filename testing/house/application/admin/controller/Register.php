<?php

namespace app\admin\controller;

use think\Controller;
use app\admin\model\Admin as AdminModel;
use app\admin\validate\Register as RegisterValidate;

class Register extends Controller
{
    /**
     * 注册页面
     * @return mixed
     */
    public function index()
    {
        if (request()->isPost()) { //判断是否post提交
            //创建register的验证实例
            $validate = new RegisterValidate;
            //创建admin的model实例
            $admin = new AdminModel;
            //验证前台传过来的表单数据
            $result = $validate->batch()->check($_POST);
            //定义username模板变量，传输到模板视图中
            $this->assign('username', $_POST['username']);
            //对用户注册数据进行校验
            if ($result === false) {//数据错误,输出错误信息
                $this->assign('validate', $validate->getError());
            } else {
                //用户注册
                $flag = $admin->register($_POST["username"], $_POST["password"]);
                if ($flag > 0) { //注册成功
                //  $this->success("注册成功", "index/index");
                    $this->redirect("login/index");
                } else {
                    switch ($flag) {
                        case -1:
                            $error = '用户已存在，请重新输入用户名!';
                            break;
                        default:
                            $error = '未知错误！';
                            break;
                    }
                    $this->assign("error", $error);
                }
            }
        }
        return $this->fetch();
    }


}
