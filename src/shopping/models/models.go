package models

import (
    "github.com/astaxie/beego/orm"
    _ "github.com/go-sql-driver/mysql"
    "github.com/astaxie/beego"
    "shopping/helper"
)

type User struct {
    Id          int
    Username    string
    Password    string
}
type Product struct{
  Id      int
  Name    string
  Stock   int//库存数量
  Price   float64 `orm:"digits(8);decimals(2)"`
  Remarks string
  Img     string
}
type Item struct{
  Id        int
  Pid       int
  Uid       int
  Oid       int
  Remarks   string
  Flag      int
  //Product   *Product //状态 `orm:fk`
}
type Itemnum struct{
  Id      int
  Itemid  int
  Num     int
}

type Order struct{
  Id          int
  Uid         int
  Totalprice  float64 `orm:"digits(8);decimals(2)"`
  Remarks     string
}
/*
type Items struct{
  Itemid   int
  Uid      int
  Pname    string
  Num      int
  Iremarks string
  Premarks string
}*/


func init() {
                                     //设置数据库最大连接数
	orm.RegisterModel(new(User),new(Product),new(Item),new(Itemnum),new(Order))                        //注册模型并使用表前缀
  //orm.RunCommand()
}

func (u *User) Add(uid int,username string,password string) (int64,error) {
	o := orm.NewOrm()
  var user User
  user.Id = uid
  user.Username = username
  user.Password = password
	//usr := User{Id: uid, Username: username, Password: password}
	id, err := o.Insert(&user)
  return id, err
}
//新增item，如果pid，uid，flag=0则更新
func (i *Item) Additem(pid int,uid int,num int) (string) {

	o := orm.NewOrm()
  beego.Debug("Additem","76")
  var item Item
  err := o.QueryTable("Item").Filter("pid", pid).Filter("uid",uid).Filter("flag",int(0)).One(&item)
  if err == orm.ErrMultiRows {
    // 多条的时候报错
    return "multiRow-models.go-line83"
    }
    if err == orm.ErrNoRows {
    // 没有找到记录
      item.Pid = pid
      item.Remarks = "无"
      item.Flag = int(0)
      item.Uid = int(3)
      item.Oid = int(0)
      beego.Debug("Additem","91")
      id, ierr := o.Insert(&item)
      if ierr == nil{
        var itns Itemnum
          itnid,itnerr :=itns.Additem(int(id),num)
          if itnerr == nil{
            return  helper.I64ts(id)+"添加成功"+helper.I64ts(itnid)
          }
          return "数据插入错误"
      }
      beego.Debug("Additem","100")
      return "数据插入错误"

    }
/*这个方法增加不起作用。。
  num, err := o.QueryTable("Itemnum").Filter("itemid",item.Id).Update(orm.Params{
    "num": o.ColValue(o.Col_Add, num),
})*/

    res, errrow := o.Raw("UPDATE Itemnum SET num = num + ? WHERE Itemid = ?", num, item.Id).Exec()
  //  res, err := o.Raw("UPDATE user SET name = ?", "your").Exec()
    if errrow == nil {
      num, _ := res.RowsAffected()
      return helper.I64ts(num)+"更新成功"
    }

    return "更新失败"
    }


      //beego.Debug(err)

func (n *Itemnum) Addmin(itid int, num int)(string){
    o := orm.NewOrm()
    res, errrow := o.Raw("UPDATE Itemnum SET num = ? WHERE Itemid = ?", num, itid).Exec()
  //  res, err := o.Raw("UPDATE user SET name = ?", "your").Exec()
    if errrow == nil {
      num, _ := res.RowsAffected()
      return helper.I64ts(num)+"更新成功"
    }

    return "更新失败"

}

func (n *Order) Addorder(ids []string,uid int,remarks string, totalp float64)(string){
    o := orm.NewOrm()
    var order Order
    order.Uid = uid
    order.Totalprice = totalp
    order.Remarks = remarks
    beego.Debug("Addorder","143")
    //var idsarry = strings.Split(ids, ",")
    //var aaa string
    var str ="UPDATE Item SET flag = 2,oid=? WHERE Id in (0";
    for _, v := range ids {
      str=str+","+v
        }
        str = str +")"
//beego.Debug("Addorder",ids[0])
    id, err := o.Insert(&order)
    if err == nil{
      res, errrow := o.Raw(str, id).Exec()
      //res, err := o.Raw("UPDATE user SET name = ?", "your").Exec()
      if errrow == nil {
        num, _ := res.RowsAffected()
        return helper.I64ts(num)+"更新数据成功"
      }
      return "更新数据失败"
    }
    return "更新数据失败"

}

func (n *Item) Deleteitem(itid int)(string){
  o := orm.NewOrm()
  res, errrow := o.Raw("UPDATE Item SET flag = ? WHERE Id = ?", 1, itid).Exec()
//  res, err := o.Raw("UPDATE user SET name = ?", "your").Exec()
  if errrow == nil {
    num, _ := res.RowsAffected()
    return helper.I64ts(num)+"更新成功"
  }
  return "更新失败"

}



func (n *Itemnum) Additem(itid int,num int) (int64,error) {

	o := orm.NewOrm()
  var itn Itemnum
  itn.Itemid = itid
  itn.Num = num
  beego.Debug("adfadfafdafdas",itid)
	id, err := o.Insert(&itn)
  //beego.Debug(err)
  return id, err
}

func Queryitems(uid int)([]orm.Params){
  o :=orm.NewOrm()
  var maps []orm.Params
  o.Raw("select it.id as itemid,pro.`name` as proname,pro.img as img,it.remarks as remarks,itn.num as num ,pro.price as price,itn.num * pro.price as total from item as it left join itemnum as itn on it.id = itn.itemid left join product as pro on it.pid = pro.id where it.flag =? and it.uid = ?", 0,uid).Values(&maps)
  return maps
}
