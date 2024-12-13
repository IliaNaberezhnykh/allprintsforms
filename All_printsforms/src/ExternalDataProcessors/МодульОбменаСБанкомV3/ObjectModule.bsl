Функция СведенияОВнешнейОбработке() Экспорт 
	
	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке("2.3.1.73");
	ПараметрыРегистрации.Информация = НСтр("ru = 'Единый модуль обмена с банком. Используется для обмена информацией между базами 1С и клиент-банком.'");
	ПараметрыРегистрации.Вид = ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка();
	ПараметрыРегистрации.Версия = "2.3.3.42";
	ПараметрыРегистрации.Назначение.Добавить("Подсистема.ВыплатыПеречисления");
	ПараметрыРегистрации.БезопасныйРежим = Ложь;
	
	Команда = ПараметрыРегистрации.Команды.Добавить();
	Команда.Представление = НСтр("ru = 'Запуск единого модуля'");
	Команда.Идентификатор = "Модуль";
	Команда.Использование = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	
	
	//Команда.Использование = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
	Команда.ПоказыватьОповещение = Истина;


	
Возврат ПараметрыРегистрации;
	
КонецФункции


мТипКонфигурации = Метаданные.Представление();
мВерсия = "";

Если мТипКонфигурации = "Зарплата и управление персоналом, редакция 3.0" или мТипКонфигурации = "Зарплата и управление персоналом (базовая), редакция 3.0"
	или мТипКонфигурации = "Зарплата и управление персоналом, редакция 3.1" или мТипКонфигурации = "Зарплата и управление персоналом (базовая), редакция 3.1"
	или мТипКонфигурации = "Зарплата и управление персоналом КОРП, редакция 3.1" или мТипКонфигурации = "1С:ERP Управление предприятием 2" 
	Тогда 
		мВерсия = "ЗУП30";
	ИначеЕсли
		мТипКонфигурации = "Зарплата и кадры государственного учреждения КОРП, редакция 3.1" или мТипКонфигурации = "Зарплата и кадры государственного учреждения (базовая), редакция 3.1" 
		или мТипКонфигурации = "Зарплата и кадры государственного учреждения, редакция 3.1"
		Тогда
		мВерсия = "ЗКГУ30"
	ИначеЕсли мТипКонфигурации = "1С-КАМИН:Зарплата. Версия 5.0" или мТипКонфигурации = "1С-КАМИН: Зарплата для бюджетных учреждений. Версия 5.5" Тогда
		мВерсия = "КАМИН"
	ИначеЕсли мТипКонфигурации = "Бухгалтерия предприятия, редакция 3.0" или мТипКонфигурации = "Бухгалтерия предприятия (базовая), редакция 3.0"  или мТипКонфигурации = "Бухгалтерия предприятия КОРП, редакция 3.0" Тогда
		мВерсия = "БП30"

КонецЕсли; 




