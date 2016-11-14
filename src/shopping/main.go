package main

import (
	_ "shopping/routers"
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
	"github.com/astaxie/beego"
)
func init() {
	// PostgreSQL 配置
	/*		pname:=beego.AppConfig.String("psqlnickname")
			puser:=beego.AppConfig.String("drivetype")
			connectstr:=beego.AppConfig.String("psqlconnectstr")

	    orm.RegisterDriver("postgres", orm.DRPostgres) // 注册驱动
	    orm.RegisterDataBase(pname, puser,connectstr)*/

	// Mysql 配置
	connectstr := beego.AppConfig.String("mysqlconnectstr")
	orm.RegisterDriver("mysql", orm.DRMySQL)             //注册数据库驱动
	orm.RegisterDataBase("default", "mysql", connectstr) //注册一个别名为default的数据库*/

	// 自动建表
	orm.RunSyncdb("default", false, true)

}
func main() {
	beego.Run()
}
