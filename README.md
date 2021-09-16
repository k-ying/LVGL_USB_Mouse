# LVGL_USB_Mouse
A simple tool using PC mouse via USART to control MCU and LCD/OLED (with LVGL library), if your screen cannot be controlled by touch.
> 如果你的屏幕无法通过触摸控制，这是一个使用 PC 鼠标串口控制 MCU 和 LCD/OLED（带有 LVGL 库）的简单工具。~~PS:因为懒得买带触摸的屏幕，又想简单学下LVGL所以做了这么个小工具。~~

## F103VE_HAL_LVGL4ST7735

MCU&LCD Tools, Take STM32F03VET6 using LCD(ST7735) and LVGL7.11 for example.
It's easy to transplant, only modify the LCD I/O&Driver.
> MCU&LCD工具，以STM32F03VET6使用LCD(ST7735)和LVGL7.11为例。
> 易于移植，只需要修改LCD I/O口和驱动即可。

USART Printing Data Format: 'X=xxx,Y=xxx,CK=x\r\n',the horizontal and vertical coordinates are X, Y, and CK indicates whether it is touched/pressed.
> 串口打印的数据格式:'X=xxx,Y=xxx,CK=x\r\n'，横纵坐标分别是X、Y,CK表示是否被触摸/按下。

You can use Keil5 MDK and Segger Embedded Studio to open the project.
> 可使用Keil5 MDK以及 Segger Embedded Studio 打开该工程。

## Qt_lvgl_USB_Mouse
The PC tools, through the serial port to send mouse coordinate data to control the LCD screen pointer, using Qt5 Quick development,which can Cross-platform compilation ,it's easy to use.
> 配套使用的PC端小工具，通过串口发送鼠标坐标数据来控制LCD屏幕指针，使用Qt5 quick开发，可跨平台编译，简单易用。
