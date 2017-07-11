
#import <Foundation/Foundation.h>
#define USERACCOUNT @"userAccount"//账号
#define USERID @"userId"//ID
#define USERNAME @"userName"//用户名
#define USERPWD @"userPwd"//密码
#define USERLOGO @"userLogo"//头像
#define USERTOKEN @"userToken"//口令
#define USERADDRESS @"userAddress"//地址
#define USERLONGITUDE @"userlongitude"//经度
#define USERLATITUDE @"userlatitude"//维度
#define USERTYPE @"usertype"//用户级别
#define USERSIGN @"userSign"//用户签名
#define USERMONY @"usermony"//用户金额
#define USERSTATUS @"userstatus"//用户状态
#define USERCARDS @"usercards"//用户银行卡号
#define USERPHONE @"userphone"//手机号
#define USERIDCARD @"useridcard"//身份证号
#define USERWECHARTNUM @"userWechartnum"//微信号
#define USERQQNUMBER @"userQQnumber"//QQ号
#define USERSEX @"userSex"//性别
#define USERAGE @"userAge"//年龄
#define USERPROTECT @"userProtect"//账号保护
#define USEREMAIL @"userEmail"//邮箱
#define USERDEVICES @"userDevices"//登录设备
#define USERSYSTEM @"userSystem"//手机系统
#define USERIP @"userIP"//手机登录的IP地址
#define USERREALNAME @"userRealName"//真实姓名

@class BaseViewController;
///1成功 0失败 2未知错误
typedef void (^LoginSuc)(NSInteger NoLogin);
@interface Utility : NSObject
#pragma mark 用户相关属性
@property (nonatomic, strong) NSString *userAccount;//账号
@property (nonatomic, strong) NSString *userId;//ID
@property (nonatomic, strong) NSString *userName;//用户名
@property (nonatomic, strong) NSString *userPwd;//密码
@property (nonatomic, strong) NSString *userLogo;//头像
@property (nonatomic, strong) NSString *userToken;//口令
@property (nonatomic, strong) NSString *userAddress;//地址
@property (nonatomic, strong) NSString *userlongitude;//经度
@property (nonatomic, strong) NSString *userlatitude;//维度
@property (nonatomic, strong) NSString *usertype;//用户级别
@property (nonatomic, strong) NSString *userSign;//用户签名
@property (nonatomic, strong) NSString *usermony;//用户金额
@property (nonatomic, strong) NSString *userstatus;//用户状态
@property (nonatomic, strong) NSString *usercards;//用户银行卡号
@property (nonatomic, strong) NSString *userphone;//手机号
@property (nonatomic, strong) NSString *useridcard;//身份证号
@property (nonatomic, strong) NSString *userWechartnum;//微信号
@property (nonatomic, strong) NSString *userQQnumber;//QQ号
@property (nonatomic, strong) NSString *userSex;//性别
@property (nonatomic, strong) NSString *userAge;//年龄
@property (nonatomic, strong) NSString *userProtect;//账号保护
@property (nonatomic, strong) NSString *userEmail;//邮箱
@property (nonatomic, strong) NSString *userDevices;//登录设备
@property (nonatomic, strong) NSString *userSystem;//手机系统
@property (nonatomic, strong) NSString *userIP;//手机登录的IP地址
@property (nonatomic, strong) NSString *userRealName;//真实姓名
@property(nonatomic,weak)BaseViewController *currentViewController;
@property (nonatomic,assign) BOOL offline;//启用缓存
@property (nonatomic,strong) LoginSuc loginSuc;
@property (nonatomic,strong)UITabBarController *CustomTabBar_zk;
///单例初始化
+(id)Share;

#pragma mark 登录相关
///显示登陆注册界面
- (void)showLoginAlert;
///隐藏登录注册界面
- (void)hiddenLoginAlert;
///是否在线
-(BOOL)isLogin;
-(void)isLogin:(LoginSuc)aLoginSuc;
-(void)isLoginAccount:(NSString *)account pwd:(NSString *)password aLogin:(LoginSuc)aLoginSuc;
///用账号和密码登录
-(void)loginWithAccount:(NSString *)account pwd:(NSString *)password;
///用账号密码和验证码提交注册
-(void)registerWithAccount:(NSString *)account pwd:(NSString *)password authorCode:(NSString *)code;
#pragma mark userDefaults
///保存用户数据到本地
-(void)saveUserInfoToDefault;
///从本地读取用户数据
-(void)readUserInfoFromDefault;
///清空本地用户数据
-(void)clearUserInfoInDefault;
///删除本地数组
+ (BOOL)removeArrayObj:(id)obj fordefaultsKey:(NSString*)key;
///数组本地化
+ (void)saveArrayToDefaults:(id)obj forKey:(NSString*)key;
///数组本地替换
+ (void)saveArrayToDefaults:(id)obj replace:(id)oldobj forKey:(NSString*)key;
#pragma mark 时间戳
///时间戳格式化时间yyyy-MM-dd HH:mm
-(NSString *)timeToTimestamp:(NSString *)timestamp;
///计算时间差
-(NSString *)timeToNow:(NSString *)theDate;
#pragma mark 数据格式化
///格式化电话号码
-(NSString *)FormatPhone:(NSString *)str;
///格式化身份证号
-(NSString *)FormatIDC:(NSString *)str;
///格式化组织机构代码证
-(NSString *)FormatOCC:(NSString *)str;
///格式化车牌号
-(NSString *)FormatPlate:(NSString *)str;
///格式化vin
-(NSString *)FormatVin:(NSString *)str;
///数字格式化
-(NSString*)FormatNumStr:(NSString*)nf;
///判断是否为整形
- (BOOL)isPureInt:(NSString*)string;
///判断是否为浮点形
- (BOOL)isPureFloat:(NSString*)string;
///验证邮箱
- (BOOL)validateEmail:(NSString *)candidate;
///验证手机号
- (BOOL)validateTel:(NSString *)candidate ;
#pragma mark 定位
///定位
-(void)loadUserLocation;
#pragma mark 振动与抖动
///振动
-(void)StartSystemShake;
///播放提示音
-(void)playSystemSound;
///类似qq聊天窗口的抖动效果
-(void)shakeViewAnimation:(UIView *)aV;
///view 左右抖动
-(void)leftRightAnimations:(UIView *)view;
#pragma mark 视图与界面
///背景view  在没有数据的时候用于提示用户的界面
- (UIView*)tipsView:(NSString*)str;
///圆角或椭圆
-(void)viewLayerRound:(UIView *)view borderWidth:(float)width borderColor:(UIColor *)color;
///处理图片大小
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
///通过颜色来生成一个纯色图片
- (UIImage *)imageFromColor:(UIColor *)color size:(CGSize )aSize;
///启动引导过渡图片
-(void)showStartTransitionView;
///关闭引导过渡图片
-(void)hiddenStartTransitionView;
#pragma mark 元件创建
+(UITextField *)textFieldlWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor placeholder:(NSString *)aplaceholder text:(NSString*)atext;
+(UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext;
+(UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment;
+(UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment setLineSpacing:(float)afloat;
+(UIButton*)buttonWithFrame:(CGRect)_frame title:(NSString*)_title  image:(NSString*)_image bgimage:(NSString*)_bgimage;
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image;
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image stretchW:(NSInteger)_w stretchH:(NSInteger)_h;
#pragma mark 蓝牙 语音识别 支付 分享 即时聊天 打电话
///是否支持蓝牙协议4.0
- (BOOL)whetherToSupportBluetoothProtocol;
///讯飞
//-(void)iflyView:(NSString *)str;
///拨打电话
- (void)makeCall:(NSString *)phoneNumber;
#pragma mark 版本
///获取当前app版本
-(NSString *)VersionSelect;
///判断ios版本是否高于当前版本要求
- (BOOL)isAvailableIOS:(CGFloat)availableVersion;
///更新版本
- (void)upDataVersion;
///返回字符串尺寸大小
+(CGSize)sizeOfStr:(NSString *)str andFont:(UIFont *)font andMaxSize:(CGSize)size;
@end
