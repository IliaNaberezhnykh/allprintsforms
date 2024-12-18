
&НаКлиенте
Перем ОсновнаяФорма;

&НаКлиенте
Перем МодульТиповой;

&НаКлиенте
Перем ИмяФайлаМодуля;

&НаКлиенте
Перем РасположениеМодуля;

&НаСервере
Перем ОбработкаОбъект;


//{	Сервисные методы

&НаСервере
Функция Модуль_ЯдроНаСервере()
	
	Результат = ОбработкаОбъект().Модуль_Ядро();
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция Модуль_ЯдроНаКлиенте()
	
	Результат = ОсновнаяФорма().Модуль_ЯдроНаКлиенте();
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ОсновнаяФорма() Экспорт

	Если ОсновнаяФорма = Неопределено Тогда
		ОсновнаяФорма = ВладелецФормы.ОсновнаяФорма();
	КонецЕсли;	
	
	Возврат ОсновнаяФорма;
	
КонецФункции

&НаСервере
Функция ОбработкаОбъект()
	
	Если ОбработкаОбъект = Неопределено Тогда
		
		СтруктураОбработки = ПолучитьИзВременногоХранилища(Объект.ОбщийКонтекстКлиентСервер.АдресОбработкаОбъект);
		Если Не СтруктураОбработки = Неопределено Тогда
			ОбработкаОбъект = СтруктураОбработки.ОбработкаОбъект;
		КонецЕсли;
		
		Если ОбработкаОбъект = Неопределено Тогда
			
			ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
			Попытка
				ПоместитьВоВременноеХранилище(Новый Структура("ОбработкаОбъект", ОбработкаОбъект), Объект.ОбщийКонтекстКлиентСервер.АдресОбработкаОбъект);
			Исключение
			КонецПопытки;
			
		КонецЕсли;
		
	КонецЕсли;	
	
	Возврат ОбработкаОбъект;
	
КонецФункции

//}	Сервисные методы


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Объект.Свойство("ОбщийКонтекстКлиентСервер", Объект.ОбщийКонтекстКлиентСервер);
	Параметры.Свойство("ДанныеДляОбновленияМодуля", ДанныеДляОбновленияМодуля);
	
	ПереопределитьАкутальнуюВерсиюМодуля();
	
	ЗаполнитьИсториюОбновлений();
	
	УстановитьНастройкиФормы();
	
	УстановкаНастроекДляТакси();
	
КонецПроцедуры

&НаСервере
Процедура ПереопределитьАкутальнуюВерсиюМодуля()
	
	Если НЕ ЗначениеЗаполнено(Параметры.НоваяВерсия) Тогда
		
		Модуль_Ядро = Модуль_ЯдроНаСервере();
		Модуль_Ядро.ЗаполнитьОписаниеАктуальнойВерсииМодуля(ДанныеДляОбновленияМодуля);
		Параметры.НоваяВерсия = ДанныеДляОбновленияМодуля.ОписаниеОбновленияМодуля.Версия;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьИсториюОбновлений()
	
	ОбработкаОбъект = ОбработкаОбъект();
	
	ПолеНовости = ОбработкаОбъект.ОписаниеИзмененийНовойВерсииМодуляHTML();
	
КонецПроцедуры	

&НаСервере
Процедура УстановитьНастройкиФормы()
	
	ВидимостьГруппы = Параметры.НоваяВерсия <> "0.0.0"; 
	
	Элементы.ГруппаТекстОбновления.Видимость		= ВидимостьГруппы;
	Элементы.ГруппаДляОбновленияМодуля.Видимость	= ВидимостьГруппы;
	
	Если ВидимостьГруппы Тогда
	
		Заголовок = "Скачайте и обновите модуль";
		
		Элементы.НадписьВерсияМодуля.Заголовок	= "Текущая версия модуля " + Параметры.ТекущаяВерсия
												+ " будет обновлена до версии " + Параметры.НоваяВерсия;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановкаНастроекДляТакси()
	
	Пользователь = ПользователиИнформационнойБазы.ТекущийПользователь();
	
	Если Не Пользователь = Неопределено Тогда
		
		Настройка = ХранилищеСистемныхНастроек.Загрузить("Общее/НастройкиКлиентскогоПриложения", "",, Пользователь.Имя);
		Если Настройка <> Неопределено
			И НЕ Модуль_ЯдроНаСервере().ПриложениеСтаршеВерсии("8.3.3")
			И Вычислить("Настройка.ВариантИнтерфейсаКлиентскогоПриложения = ВариантИнтерфейсаКлиентскогоПриложения.Такси") Тогда
			
			Элементы.Декорация1.Видимость = Ложь;
			
			Элементы.ПолеНовости.Ширина = 80;
			Элементы.ГруппаДляОбновленияМодуля.Ширина = 80;
			
			Элементы.Декорация2.Видимость = Ложь;
			Элементы.Декорация3.Видимость = Ложь;
			Элементы.НадписьВерсияМодуля.Ширина = 98;
									
		КонецЕсли;
		
	КонецЕсли;
	
	НастройкиЭлемента = Новый Структура;
	НастройкиЭлемента.Вставить("ВертикальноеПоложениеВГруппе", ВертикальноеПоложениеЭлемента.Центр);
	НастройкиЭлемента.Вставить("ВертикальноеПоложение", ВертикальноеПоложениеЭлемента.Центр);
	ЗаполнитьЗначенияСвойств(Элементы.НадписьОнлайнКонсультант1, НастройкиЭлемента);
	ЗаполнитьЗначенияСвойств(Элементы.НадписьПисьмоВТехподдержку, НастройкиЭлемента);
	ЗаполнитьЗначенияСвойств(Элементы.НадписьОнлайнКонсультант, НастройкиЭлемента);
	
КонецПроцедуры	

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	Модуль_ЯдроНаКлиенте().Метрика_ДобавитьСтатистику_ПоКонтексту("Скачать обновление", "Открытие формы", "Форма обновления");
	
	ОформлениеФормыМодульТиповой();
	
	ОпределитьДействияДляОбновленияМодуля();

КонецПроцедуры

//варианты действий пользователя для обновления модуля, в зависимости от его расположения
//
&НаКлиенте
Процедура ОпределитьДействияДляОбновленияМодуля()
	
	Если Параметры.НоваяВерсия = "0.0.0" Тогда
		Возврат;
	КонецЕсли;
	
	ПоказатьВозможныеДействияДляОбновленияМодуля();
		
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьВозможныеДействияДляОбновленияМодуля() 
	
	Ядро = Модуль_ЯдроНаКлиенте();
	МодульДоработан = Не Ядро.ЭтоТиповойМодуль();
	
	Если МодульДоработан Тогда
		
		ОформлениеФормыМодульДоработан();
		
	Иначе
		
		ОформлениеФормыМодульТиповой();
		
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура ОформлениеФормыМодульТиповой() 
	
	МодульТиповой = "Да";
	
	Заголовок = "Скачайте и обновите модуль";
	Элементы.НадписьУспокаивающая.Заголовок		= "Обновление модуля не влияет на работу 1С, все ваши данные будут сохранены.";
	
	Элементы.ПанельКнопокБезДоработок.Видимость	= Истина;
	Элементы.ПанельКнопокСДоработками.Видимость	= Ложь;
	
КонецПроцедуры	

&НаКлиенте
Процедура ОформлениеФормыМодульДоработан() 
	
	МодульТиповой = "Нет";
	
	Заголовок = "Обновление модуля с доработками";
	
	ОписаниеРасположениеМодуля = Объект.ОбщийКонтекстКлиентСервер.РасположениеМодуля;
	
	Если ОписаниеРасположениеМодуля = Неопределено 
		ИЛИ ИмяФайлаМодуля = "" 
		ИЛИ РасположениеМодуля = "ВКонфигурации" 
		Тогда
		
		Элементы.НадписьУспокаивающая.Заголовок = "Возможно, ваш" + Сред(Элементы.НадписьУспокаивающая.Заголовок, 4);
	
	КонецЕсли;
	
	Элементы.ПанельКнопокБезДоработок.Видимость = Ложь;
	Элементы.ПанельКнопокСДоработками.Видимость = Истина;
	
КонецПроцедуры	


&НаКлиенте
Процедура КнопкаСкачатьОбновлениеМодуля(Команда)
	
	Метрика_НажатиеКнопкиФормыОбновления("Скачать обновление модуля");
	
	СохранитьФайлОбновления();
	
КонецПроцедуры

&НаКлиенте
Процедура КнопкаОставитьЗаявкуНаОбновление(Команда)
	
	Метрика_НажатиеКнопкиФормыОбновления("Оставить заявку на обновление");
	
	ОставитьЗаявкуНаОбновление();
	
КонецПроцедуры

&НаКлиенте
Процедура НадписьОнлайнКонсультантНажатие(Элемент)
	
	Категория = Метрика_НазваниеКатегории();
	НазваниеФормы = Метрика_НазваниеФормы();
	
	ОсновнаяФорма().ЦентрПоддержки_Открыть(Категория, НазваниеФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура НадписьПисьмоВТехподдержкуНажатие(Элемент)
	
	Метрика_НажатиеКнопкиФормыОбновления("Написать письмо в техподдержку");
	
	ОсновнаяФорма().Обработчик_ОтправитьEmail(, "Скачать обновление");
	
КонецПроцедуры


//сохранение файла с новой версией модуля
//
&НаКлиенте
Процедура СохранитьФайлОбновления()
	
	ДиалогОткрытияФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	
	ДиалогОткрытияФайла.ПолноеИмяФайла = "";
	ДиалогОткрытияФайла.Фильтр = НСтр("ru = 'Все файлы(*.*)|*.*'");;
	ДиалогОткрытияФайла.МножественныйВыбор = Ложь;
	ДиалогОткрытияФайла.Заголовок = НСтр("ru = 'Выберите каталог'");
	
	Если ДиалогОткрытияФайла.Выбрать() Тогда
		
		ИмяКаталога = ДиалогОткрытияФайла.Каталог;
		СоздатьКаталог(ИмяКаталога);
		
		ВозможныеМестоположения = ДанныеДляОбновленияМодуля.Перечисления.МестоположенияМодуля;
		ОписаниеРасположенияМодуля = ДанныеДляОбновленияМодуля.ОписаниеРасположенияМодуля;
		
		Если ОписаниеРасположенияМодуля.Местоположение = ВозможныеМестоположения.РасширениеКонфигурации Тогда
			РасширениеФайла = ".cfe";
		Иначе
			РасширениеФайла = ".epf";
		КонецЕсли;
		
		ИмяФайлаОбновления = "Diadoc_" + СтрЗаменить(Параметры.НоваяВерсия, ".", "_") + РасширениеФайла;
		ИмяФайлаОбновленияНаДиске = ИмяКаталога + "\" + ИмяФайлаОбновления;
		
		Попытка
			
			ФайлОбновления = ФайлНовойВерсииМодуляВызовСервера(ДанныеДляОбновленияМодуля.ОписаниеОбновленияМодуля.СсылкаНаФайл);
			
			Если ФайлОбновления = Неопределено Тогда
				Возврат;
			КонецЕсли;
			
		Исключение
			
			ТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ОшибкаПолученияФайла(ТекстОшибки);
			
			Возврат;
			
		КонецПопытки;
		
		ФайлОбновления.Записать(ИмяФайлаОбновленияНаДиске);
		
		ТекстСообщения = ТекстСообщенияСохраненияОбновления(ИмяФайлаОбновленияНаДиске);
		
		СообщениеПользователю = Новый СообщениеПользователю;
		СообщениеПользователю.Текст = ТекстСообщения;
		СообщениеПользователю.Сообщить();
		
		Метрика_СтатистикаФормыОбновления("Скачать обновление модуля");
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ФайлНовойВерсииМодуляВызовСервера(СсылкаНаФайл)
	
	Ядро = Модуль_ЯдроНаСервере();
	
	Результат = Ядро.ФайлНовойВерсииМодуля(СсылкаНаФайл);
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ТекстСообщенияСохраненияОбновления(ИмяФайлаОбновленияНаДиске)
	
	Результат = "Файл с новой версией модуля успешно сохранен: " + ИмяФайлаОбновленияНаДиске;
	
	Перечисление_МестоположенияМодуля = Модуль_ЯдроНаКлиенте().Перечисление_МестоположенияМодуля();
	
	Если РасположениеМодуля = Перечисление_МестоположенияМодуля.ОбработкаКонфигурации Тогда 
		
		Результат = Результат + "
		|Обновите обработку в конфигураторе.";
		
	ИначеЕсли РасположениеМодуля = Перечисление_МестоположенияМодуля.ЭлементСправочника Тогда 
		
		Результат = Результат + "
		|Обновите модуль в справочнике 1С.";
		
	ИначеЕсли РасположениеМодуля = Перечисление_МестоположенияМодуля.ФайлНаДиске Тогда 
		
		Результат = Результат + "
		|Используйте новый файл для работы.";
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции	

&НаКлиенте
Процедура ОшибкаПолученияФайла(ТекстОшибки)
	
	ВидОперации = НСтр("ru = 'Ошибка получения файла обновления'");
	
	Ядро = Модуль_ЯдроНаКлиенте();
	
	Ядро.Ошибка_Обработать(ВидОперации, ТекстОшибки);
	
	Если Найти(ТекстОшибки, "Not Found") <> 0 Тогда 
		ОсновнаяФорма().ПоказатьПредупреждениеПереопределенная(, "Файл не обнаружен.", 120);
		Метрика_ЛогиФормыОбновления("Скачать обновление модуля", "Файл не обнаружен");
	Иначе
		
		СообщениеПользователю =	Новый СообщениеПользователю;
		СообщениеПользователю.Текст = ТекстОшибки;
		СообщениеПользователю.Сообщить();
		
		Метрика_ЛогиФормыОбновления("Скачать обновление модуля", ТекстОшибки);
		
	КонецЕсли;
	
КонецПроцедуры	

// Открываем форму заполнения заявки на обновление модуля в браузере
//
&НаКлиенте
Процедура ОставитьЗаявкуНаОбновление()
	
	Попытка
		ЗапуститьПриложение("https://www.diadoc.ru/order1c?comment=модуль_1C_8_2_8_3_pro#:~:text=Заявка%20на%C2%A0интеграцию");
	Исключение
		
		Ошибка = ИнформацияОбОшибке();
		
		СообщениеПользователю = Новый СообщениеПользователю;
		СообщениеПользователю.Текст = КраткоеПредставлениеОшибки(Ошибка);
		СообщениеПользователю.Сообщить();
		
		Метрика_ЛогиФормыОбновления("Оставить заявку на обновление", ПодробноеПредставлениеОшибки(Ошибка));
		
		Возврат;
		
	КонецПопытки;
	
	СообщениеПользователю = Новый СообщениеПользователю;
	СообщениеПользователю.Текст = "Открыта форма заявки на обновление модуля.";
	СообщениеПользователю.Сообщить();
	
	Метрика_СтатистикаФормыОбновления("Оставить заявку на обновление");
	
КонецПроцедуры


//метрики

&НаКлиенте
Процедура Метрика_НажатиеКнопкиФормыОбновления(НазваниеКнопки)
	
	Модуль_ЯдроНаКлиенте().Метрика_ДобавитьПоведение_ФормыОбновления(НазваниеКнопки, МодульТиповой, РасположениеМодуля);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрика_СтатистикаФормыОбновления(НазваниеКнопки) Экспорт
	
	Модуль_ЯдроНаКлиенте().Метрика_ДобавитьСтатистику_ПоКонтексту("Скачать обновление", НазваниеКнопки);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрика_ЛогиФормыОбновления(НазваниеКнопки, ТекстОшибки)
	
	Модуль_ЯдроНаКлиенте().Метрика_ДобавитьОшибку_ПоКонтексту("Скачать обновление", НазваниеКнопки, ТекстОшибки);
	
КонецПроцедуры

&НаКлиенте
Функция Метрика_НазваниеФормы()
	
	Возврат "Форма обновления";
	
КонецФункции

&НаКлиенте
Функция Метрика_НазваниеКатегории()
	
	Результат = Метрика_ВозможныеКатегории().СкачатьОбновление;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция Метрика_ВозможныеКатегории()

	Результат = Модуль_ЯдроНаКлиенте().Метрика_НазваниеКатегории();
	
	Возврат Результат;
	
КонецФункции
