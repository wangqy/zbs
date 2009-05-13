功能: 调度事件
  为了及时处理值班室录入的事件
  作为调度人员
  可以对事件进行分派,处理

  场景: 转办
    假如 我已经以用户aaron身份登录
    而且 我在事件调度页面
    而且 有以下数据:
      |事件编号|事件主题|登记时间|登记人|
      |深电2009032300022|孙先生投诉物业|03-23 14:14|清亭|
      |深电2009032300099|马先生投诉|03-24 22:22|清亭|
    当 我在第2条记录中点击办理按钮
    那么 我应该能看到:13988889999
    那么 我应该能看到:未安排
    而且 我输入办理意见为以上来电反映情况转你单位阅处.
    而且 我选中转办
    而且 我选择接收部门为劳动局
    而且 我选择相关责任人为机构人员
    而且 我输入备注为请尽快处理
    当 我点击提交
    那么 我将看到以下数据:
      |事件编号|事件主题|登记时间|登记人|
      |深电2009032300022|孙先生投诉物业|03-23 14:14|清亭|
    而且 劳动局的机构人员立即收到短信通知

  场景: 直接办结
    假如 我已经以用户aaron身份登录
    而且 我在事件调度页面
    而且 有以下数据:
      |事件编号|事件主题|登记时间|登记人|
      |深电2009032300022|孙先生投诉物业|03-23 14:14|清亭|
      |深电2009032300099|马先生投诉|03-24 22:22|清亭|
    当 我在第2条记录中点击办理按钮
    那么 我应该能看到:13988889999
    当 我选中直接办结
    而且 我点击提交
    那么 我将看到以下数据:
      |事件编号|事件主题|登记时间|登记人|
      |深电2009032300022|孙先生投诉物业|03-23 14:14|清亭|
      
  场景: 自己受理
    假如 我已经以用户aaron身份登录
    而且 我在事件调度页面
    而且 有以下数据:
      |事件编号|事件主题|登记时间|登记人|
      |深电2009032300022|孙先生投诉物业|03-23 14:14|清亭|
      |深电2009032300099|马先生投诉|03-24 22:22|清亭|
    当 我在第2条记录中点击办理按钮
    那么 我应该能看到:13988889999
    当 我选中自己受理
    而且 我点击提交
    那么 我将看到以下数据:
      |事件编号|事件主题|登记时间|登记人|
      |深电2009032300022|孙先生投诉物业|03-23 14:14|清亭|

  场景: 添加往来记录
    假如 我已经以用户dispatcher身份登录
    而且 我在事件调度页面
    当 我在第1条记录中点击添加往来记录按钮
    那么 我应该能看到: 事件:孙先生投诉物业 物业管理不到位,小区经常发生偷窃事件
    而且 我应该能看到往来记录:
      |03-23 孙小 来访|
    而且 我应该能看到处理过程:
      |03-25 (劳动局)阿郎 转办 (劳动局)机构人员 : 转你处办理| 
    而且 我选中孙小
    而且 我选中回电
    而且 我输入内容摘要为通知联系人,已经对非法营业摊档进行清理
    当 我点击保存
    那么 我应该能看到:保存成功
