&НаСервере
Перем ОбработкаОбъект;
&НаСервере
Перем ИменаСправочниковДиадок;

//{		Сервисные методы
	
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

&НаСервере
Функция Модуль_ЯдроНаСервере()
	
	Результат = ОбработкаОбъект().Модуль_Ядро();
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ОсновнаяФорма() Экспорт
	
	Результат = ВладелецФормы.ОсновнаяФорма();
	
	Возврат Результат;
	
КонецФункции

//}		Сервисные методы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Параметры.Объект.Свойство("ОбщийКонтекстКлиентСервер", Объект.ОбщийКонтекстКлиентСервер);
	
	ОбновитьСписокНаСервере();
	
	ЭтаФорма.Заголовок = "Подразделения: " + Параметры.ДанныеВладельца.Наименование;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьСписокНаСервере()
	
	СписокПодразделений	= Модуль_ЯдроНаСервере().Подразделения_СписокПодразделений(Параметры.ДанныеВладельца, Параметры.ДанныеОрганизации);
	
	мДеревоПодразделений = РеквизитФормыВЗначение("ДеревоПодразделений");
	мДеревоПодразделений.Строки.Очистить();
	
	ОбработкаОбъект().ЗаполнитьДеревоПодразделений(мДеревоПодразделений, СписокПодразделений, "ID_РодительПодразделения", "");
	
	Если ЗначениеЗаполнено(Параметры.ДанныеВладельца) И Не ЗначениеЗаполнено(Параметры.ДанныеОрганизации) Тогда
		ИмяСправочника = ИменаСправочников_Диадок().Организации;
	Иначе
		ИмяСправочника = ИменаСправочников_Диадок().Контрагенты;
	КонецЕсли;
	
	ОбработкаОбъект().ЗаполнитьПредставлениеСвязейВДеревеПодразделений(	мДеревоПодразделений.Строки,
																		ИмяСправочника,
																		Параметры.ДанныеВладельца.ID);
	
	ЗначениеВРеквизитФормы(мДеревоПодразделений, "ДеревоПодразделений");
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОбновитьСписок(Команда)
	
	ОбновитьСписокНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Диадок_Сохранение_Подразделение" Тогда
		ОбновитьСписокНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоПодразделенийВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ВыбратьЭлементСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьЭлементСписка()
	
	ТекСтрока = Элементы.ДеревоПодразделений.ТекущиеДанные;
	
	Если ТекСтрока <> Неопределено Тогда

		ДанныеПодразделения = ПодразделениеИзСтрокиДанных(ТекСтрока.ДанныеПодразделения);
		ЭтаФорма.Закрыть(ДанныеПодразделения);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПодразделениеИзСтрокиДанных(ДанныеСтрокиТЧ)
	
	Результат = ЗначениеИзСтрокиВнутр(ДанныеСтрокиТЧ);
	
	Возврат Результат;
	
КонецФункции

Функция ИменаСправочников_Диадок()
	
	Если ИменаСправочниковДиадок = Неопределено Тогда
		ИменаСправочниковДиадок = Модуль_ЯдроНаСервере().Перечисление_ИменаСправочников_Диадок();
	КонецЕсли;
	
	Возврат ИменаСправочниковДиадок;
	
КонецФункции

