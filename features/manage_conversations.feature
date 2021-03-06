功能: 受理事件
  为了快速录入来电,来访等信息
  作为值班室人员
  可以受理事件

  场景: 新增来电事件
    假如 我已经以用户aaron身份登录
    而且 我在受理事件页面
    而且 我输入联系电话为13977778888
    当 我单击按钮查询
    当 我触发链接增加新事件
    那么 我应该能看到输入的值:13977778888
    而且 我输入姓名为马波
    而且 我输入事件的其他信息
    当 我点击保存
    那么 我应该能看到:保存成功

  场景: 增加小事件
    假如 我已经以用户aaron身份登录
    而且 我在受理事件页面
    而且 我输入联系电话为13988889999
    当 我单击按钮查询
    那么 我应该能看到: 楼下还是太吵了
    而且 我应该能看到子事件:
      |03-24 马波 来电|
      |03-25 (劳动局)阿郎 回电 马波 了解详细情况|
      |03-29 马波 来访 问题仍然存在,要求尽快协调|
      |04-01 (劳动局)机构人员 回访 马波 已查处楼下烧烤摊|
    当 我触发链接关联
    而且 我应该能看到往来记录:
      |03-24 马波 来电|
      |03-25 (劳动局)阿郎 回电 马波 了解详细情况|
      |03-29 马波 来访 问题仍然存在,要求尽快协调|
      |04-01 (劳动局)机构人员 回访 马波 已查处楼下烧烤摊|
    而且 我应该能看到处理过程:
      |03-25 (劳动局)阿郎 自己受理| 
    而且 我输入内容摘要为询问事件进展情况
    当 我点击保存
    那么 我应该能看到:保存成功

  场景: 查看事件
    假如 我已经以用户aaron身份登录
    而且 我在事件记录页面
    而且 我输入事件主题为马先生投诉
    当 我单击按钮查询
    那么 我将看到以下数据:
      |事件编号|事件主题|登记时间|登记人|
      |深电2009032300099|马先生投诉|03-24 22:22|清亭|
    当 我在第1条记录中点击查看按钮
    那么 我应该能看到:13988889999
    那么 我应该能看到:楼下还是太吵了

  场景: 管理事件分类
    假如: 我已经以用户aaron身份登录
    而且 我在事件分类新增页面
    当 我选中普通事务
    而且 我输入分类名称为普通纠纷
    而且 我输入期限为30
    当 我点击保存
    那么 浏览器后台返回:新增事件分类成功
