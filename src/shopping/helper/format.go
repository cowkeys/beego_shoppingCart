package helper

import (
    //"github.com/astaxie/beego/orm"
    //_ "github.com/go-sql-driver/mysql"
    //"github.com/astaxie/beego"
    "strconv"
)



func init() {

}
//int 转 string
func Its(num int) (string) {
  i := int64(num)
	return strconv.FormatInt(i, 10)
}
func I64ts(num int64) (string) {
	return strconv.FormatInt(num, 10)
}
func Sti(s string) (int) {
  intid, err := strconv.Atoi(s)
  if err==nil{
    return int(intid)
  }
	return int(intid)
}

func Stf64(s string) (float64) {
  f, err := strconv.ParseFloat(s, 64)
  if err==nil{
    return f
  }
	return float64(0)
}
