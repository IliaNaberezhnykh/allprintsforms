&НаКлиенте
Функция ОсновнаяФорма() Экспорт
	
	Результат = ВладелецФормы.ОсновнаяФорма();
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция Модуль_ЯдроНаКлиенте()
	
	Результат = ОсновнаяФорма().Модуль_ЯдроНаКлиенте();
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Объект.Свойство("ОбщийКонтекстКлиентСервер", Объект.ОбщийКонтекстКлиентСервер);
	Параметры.Свойство("КомпоновщикНастроек", КомпоновщикНастроек);
	Параметры.Свойство("КомпоновщикПоУмолчанию", КомпоновщикПоУмолчанию);
	Параметры.Свойство("ДанныеОрганизации", ДанныеОрганизации);
	Параметры.Свойство("ТекущийРежимСписка", ТекущийРежимСписка);
	
	Элементы.ФильтрыСпискаДокументовГруппаКолонокЛевоеЗначение.Доступность = Ложь;
	Заголовок = "Фильтр Контрагентов";
	
	ИнициализироватьИдентификаторТрассировки();
	
КонецПроцедуры

&НаСервере
Процедура ИнициализироватьИдентификаторТрассировки()
	
	Метрики_НаименованиеФормы = Метрики_НаименованиеФормы();
	СтрокаИдентификатора = Строка(Новый УникальныйИдентификатор());
	
	ИдентификаторТрассировки = Метрики_НаименованиеФормы + "_" + СтрокаИдентификатора;
	
КонецПроцедуры

&НаКлиенте
Процедура Применить(Команда)
	
	Метрики_ЗаписатьПоведение_Применить();
	
	Закрыть(КомпоновщикНастроек);
	
	Метрики_ЗаписатьСтатистику_Применить();
	
КонецПроцедуры

&НаКлиенте
Процедура Отменить(Команда)
	
	Метрики_ЗаписатьПоведение_Закрыть();
	
	Закрыть();
	
	Метрики_ЗаписатьСтатистику_Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура СброситьНажатие(Элемент)
	
	Метрики_ЗаписатьПоведение_СброситьВсеФильтры();
	
	ЭлементыОтбораКомпоновки = КомпоновщикНастроек.Настройки.Отбор.Элементы;
	ЭлементыОтбораКомпоновки.Очистить();
	
	ОтборКомпоновкиПоУмолчанию = КомпоновщикПоУмолчанию.Настройки.Отбор.Элементы;
	
	Для Каждого ЭлементОтбораПоУмолчанию Из ОтборКомпоновкиПоУмолчанию Цикл
		
		НовыйЭлементОтбора = ЭлементыОтбораКомпоновки.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЗаполнитьЗначенияСвойств(НовыйЭлементОтбора, ЭлементОтбораПоУмолчанию);
		
	КонецЦикла;
	
	Метрики_ЗаписатьСтатистику_СброситьВсеФильтры();
	
КонецПроцедуры

//{ Метрики

&НаКлиенте
Процедура Метрики_ЗаписатьПоведение_СохранитьТекущуюФильтрацию()
	
	НазваниеКнопки = Метрики_ДействиеСохранитьТекущуюФильтрацию();
	
	Метрика_НажатиеКнопкиФормы(НазваниеКнопки);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрики_ЗаписатьСтатистику_СохранитьТекущуюФильтрацию()
	
	Модуль_Ядро = Модуль_ЯдроНаКлиенте();
	Действие = Метрики_ДействиеСохранитьТекущуюФильтрацию();
	Если ТекущийРежимСписка = РежимПоискИПриглашение() Тогда
		Категория = Метрики_КатегорияПоискНовыхКонтрагентов();
	Иначе
		Категория = Метрики_КатегорияОсновнойСписокКонтрагентов();
	КонецЕсли;
	НазваниеФормы = Метрики_НаименованиеФормы();
	
	Модуль_Ядро.Метрика_ДобавитьСтатистику_ДляОрганизации(
		ДанныеОрганизации.ID,
		Категория,
		Действие, , ,
		НазваниеФормы,
		ИдентификаторТрассировки);
	
КонецПроцедуры


&НаКлиенте
Процедура Метрики_ЗаписатьПоведение_Применить()
	
	НазваниеКнопки = Метрики_ДействиеПрименить();
	
	Метрика_НажатиеКнопкиФормы(НазваниеКнопки);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрики_ЗаписатьСтатистику_Применить()
	
	Модуль_Ядро = Модуль_ЯдроНаКлиенте();
	Действие = Метрики_ДействиеПрименить();
	Если ТекущийРежимСписка = РежимПоискИПриглашение() Тогда
		Категория = Метрики_КатегорияПоискНовыхКонтрагентов();
	Иначе
		Категория = Метрики_КатегорияОсновнойСписокКонтрагентов();
	КонецЕсли;
	НазваниеФормы = Метрики_НаименованиеФормы();
	
	Переменные = Новый Структура;
	Переменные.Вставить("МассивФильтров", Метрики_ПолучитьУстановленныеФильтры());
	
	Модуль_Ядро.Метрика_ДобавитьСтатистику_ДляОрганизации(
		ДанныеОрганизации.ID,
		Категория,
		Действие, ,
		Переменные,
		НазваниеФормы,
		ИдентификаторТрассировки);
	
КонецПроцедуры


&НаКлиенте
Процедура Метрики_ЗаписатьПоведение_Закрыть()
	
	НазваниеКнопки = Метрики_ДействиеОтменить();
	
	Метрика_НажатиеКнопкиФормы(НазваниеКнопки);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрики_ЗаписатьСтатистику_Закрыть()
	
	Модуль_Ядро = Модуль_ЯдроНаКлиенте();
	Действие = Метрики_ДействиеОтменить();
	Если ТекущийРежимСписка = РежимПоискИПриглашение() Тогда
		Категория = Метрики_КатегорияПоискНовыхКонтрагентов();
	Иначе
		Категория = Метрики_КатегорияОсновнойСписокКонтрагентов();
	КонецЕсли;
	НазваниеФормы = Метрики_НаименованиеФормы();
	
	Модуль_Ядро.Метрика_ДобавитьСтатистику_ДляОрганизации(
		ДанныеОрганизации.ID,
		Категория,
		Действие, , ,
		НазваниеФормы,
		ИдентификаторТрассировки);
	
КонецПроцедуры


&НаКлиенте
Процедура Метрики_ЗаписатьПоведение_СброситьВсеФильтры()
	
	НазваниеКнопки = Метрики_ДействиеСброситьВсеФильтры();
	
	Метрика_НажатиеКнопкиФормы(НазваниеКнопки);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрики_ЗаписатьСтатистику_СброситьВсеФильтры()
	
	Модуль_Ядро = Модуль_ЯдроНаКлиенте();
	Действие = Метрики_ДействиеСброситьВсеФильтры();
	Если ТекущийРежимСписка = РежимПоискИПриглашение() Тогда
		Категория = Метрики_КатегорияПоискНовыхКонтрагентов();
	Иначе
		Категория = Метрики_КатегорияОсновнойСписокКонтрагентов();
	КонецЕсли;
	НазваниеФормы = Метрики_НаименованиеФормы();
	
	Модуль_Ядро.Метрика_ДобавитьСтатистику_ДляОрганизации(
		ДанныеОрганизации.ID,
		Категория,
		Действие, , ,
		НазваниеФормы,
		ИдентификаторТрассировки);
	
КонецПроцедуры


&НаКлиенте
Процедура Метрика_НажатиеКнопкиФормы(НазваниеКнопки)
	
	Модуль_Ядро = Модуль_ЯдроНаКлиенте();
	НазваниеФормы = Метрики_НаименованиеФормы();
	
	Если ТекущийРежимСписка = РежимПоискИПриглашение() Тогда
		Категория = Метрики_КатегорияПоискНовыхКонтрагентов();
	Иначе
		Категория = Метрики_КатегорияОсновнойСписокКонтрагентов();
	КонецЕсли;
	
	Модуль_Ядро.Метрика_ДобавитьПоведение_НажатиеКнопки(
		НазваниеФормы,
		Категория,
		НазваниеКнопки, , ,
		ИдентификаторТрассировки);
	
КонецПроцедуры

&НаСервере
Функция Метрики_ПолучитьУстановленныеФильтры()
	
	Результат = Новый Массив;
	
	Отборы = КомпоновщикНастроек.Настройки.Отбор;
	
	Для Каждого Отбор Из Отборы.Элементы Цикл
		
		Если Отбор.Использование Тогда
			Результат.Добавить(Строка(Отбор.ЛевоеЗначение));
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции


&НаКлиентеНаСервереБезКонтекста
Функция РежимПоискИПриглашение()
	
	Возврат "ПоискИПриглашение";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция Метрики_КатегорияОсновнойСписокКонтрагентов()
	
	Возврат "ОсновнойСписокКонтрагентов";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция Метрики_КатегорияПоискНовыхКонтрагентов()
	
	Возврат "ПоискНовыхКонтрагентов";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция Метрики_ДействиеСохранитьТекущуюФильтрацию()
	
	Возврат "СохранитьТекущуюФильтрацию";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция Метрики_ДействиеСброситьВсеФильтры()
	
	Возврат "СброситьВсеФильтры";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция Метрики_ДействиеПрименить()
	
	Возврат "Применить";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция Метрики_ДействиеОтменить()
	
	Возврат "Отменить";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция Метрики_НаименованиеФормы()
	
	Возврат "ФормаФильтров";
	
КонецФункции

//} Метрики