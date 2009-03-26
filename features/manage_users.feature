功能: 管理用户
  为了统一管理用户信息
  作为管理员
  可以新增、修改、删除用户
  
  场景: 用户登录
    假如 我已经以管理员cogentsoft身份登录
    那么 我应该能看到:欢迎您:cogentsoft

  场景: 新增用户
    假如 我已经以管理员cogentsoft身份登录
    而且 我在用户管理页面
    当 我输入用户名为saberma
    而且 我输入姓名为马海波
    而且 我输入密码为666666
    而且 我点击保存
    那么 我应该能看到:saberma
    而且 我应该能看到:马海波

  场景: 编辑用户
    假如 我已经以管理员cogentsoft身份登录
    而且 我在用户管理页面
    而且 有以下用户数据:
      |用户名|姓名|
      |aaron|阿郎|
      |cogentsoft|高正|
      |quentin|清亭|
    当 我修改第3个用户的姓名为清廷
    那么 我将看到以下数据:
      |用户名|姓名|
      |aaron|阿郎|
      |cogentsoft|高正|
      |quentin|清廷|

  场景: 业务操作人员登录
    假如 我已经以用户aaron身份登录
    那么 我应该能看到:新增来电
    而且 我应该看不到:用户管理
