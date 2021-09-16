# LVGL_USB_Mouse
A simple tool using PC mouse via USART to control MCU and LCD/OLED (with LVGL library), if your screen cannot be controlled by touch.
> 如果您的屏幕无法通过触摸控制，使用 PC 鼠标串口控制 MCU 和 LCD/OLED（带有 LVGL 库）的简单工具。PS:因为懒得买带触摸的屏幕，又想简单学下LVGL所以做了这么个小工具。

## F103VE_HAL_LVGL4ST7735

MCU&LCD Tools, Take STM32F03VET6 using LCD(ST7735) and LVGL7.11 for example.
It's easy to transplant, only modify the LCD I/O&Driver.

Printing Data Format: 'X=xxx,Y=xxx,CK=x\r\n'

X
