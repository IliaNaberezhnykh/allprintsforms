&НаСервере
Перем КэшМодуляОбъекта;

&НаКлиенте
Перем КэшОсновногоМодуля, ЗначениеПроизвольногоВыражения;

//{ СЛУЖЕБНЫЙ Программный интерфейс

&НаКлиенте
Функция ОсновнойМодуль() Экспорт
	
	Если КэшОсновногоМодуля = Неопределено Тогда 
		КэшОсновногоМодуля = ВладелецФормы;
	КонецЕсли;
	
	Возврат КэшОсновногоМодуля;
	
КонецФункции

&НаСервере
Функция МодульОбъекта()
	
	Если КэшМодуляОбъекта = Неопределено Тогда
		КэшМодуляОбъекта = РеквизитФормыВЗначение("Объект");
	КонецЕсли;
	
	Возврат КэшМодуляОбъекта;
	
КонецФункции
	  
//} Программный интерфейс

// { ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПараметрыСобытия = Новый Структура;
	ОсновнойМодуль().ПодключаемыйМодуль_ОбработатьСобытие("Плагин_СохранениеДокументов_ПолучитьСписокОрганизаций", ПараметрыСобытия);

	Настройки = ПолучитьНастройкиПлагина();
	ПрименитьНастройкиПлагинаНаФормеНаСервере(Настройки, ПараметрыСобытия);
	ОбновитьВидимость();

	ОбновитьПредставлениеПериода();
	УстановитьДоступностьЭлементаПрисоедиятьПФОтдельно()

КонецПроцедуры

// } ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

// { ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ФОРМЫ

&НаКлиенте
Процедура СохранитьЗакрыть(Команда)
	
	Отказ = Ложь;
	
	СохранитьНастройкиПлагина(Отказ);
	
	Если НЕ Отказ Тогда
		ЭтаФорма.Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	
	Отказ = Ложь;
	
	СохранитьНастройкиПлагина(Отказ);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьНастройкиПлагина(Отказ)
	
	СтруктураНастроек = НастройкиПлагинаВСтруктуру();
	
	ПроверитьНастройкиПередЗаписью(СтруктураНастроек, Отказ);
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ЗаписатьНастройкиПлагина(СтруктураНастроек, Отказ);
	
	ЭтаФорма.Модифицированность = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьДокументы(Команда)
	
	Если ЭтаФорма.Модифицированность Тогда
		
		Отказ = Ложь;
		
		СохранитьНастройкиПлагина(Отказ);
		
		Если Отказ Тогда
			Возврат;
		КонецЕсли;
		
	КонецЕсли;
	
	ПараметрыСобытия = Новый Структура;
	ПараметрыСобытия.Вставить("ВыполнитьСохранениеДокументов", Истина);
	ОсновнойМодуль().ПодключаемыйМодуль_ОбработатьСобытие("Плагин_СохранениеДокументов_ВыполнитьСохранениеДокументов", ПараметрыСобытия);
	
КонецПроцедуры

&НаКлиенте
Процедура ПутьКАрхивуНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыборКаталогаАрхива", ЭтаФорма);
	Диалог.Показать(ОписаниеОповещения);
КонецПроцедуры

&НаКлиенте
Процедура СмещениеКоличествоМесяцевПриИзменении(Элемент)
	
	ОбновитьПредставлениеПериода();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокОрганизацийПередНачаломИзменения(Элемент, Отказ)
	
	Если Элемент.ТекущиеДанные.Пометка Тогда
		Возврат;
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("ОтметкаСписка", ЭтаФорма, Элемент);
	ТекстОповещения = "Введите ключ для организации " + Элемент.ТекущиеДанные.Представление;
	
	ПоказатьВводСтроки(
		Оповещение,
		Неопределено,
		ТекстОповещения,
		0,
		Ложь
	);
	
	Отказ = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокОрганизацийПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура СписокОрганизацийПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПрисоединятьКДокументуПриИзменении(Элемент)

	УстановитьДоступностьЭлементаПрисоедиятьПФОтдельно();
	
КонецПроцедуры

&НаКлиенте
Процедура СписокТиповДокументовПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура СписокТиповДокументовПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

// } ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ФОРМЫ

// { РАБОТА С НАСТРОЙКАМИ

&НаКлиенте
Функция ПолучитьНастройкиПлагина()

	Результат = Неопределено;
	
	Идентификатор = ИдентификаторПлагина();
	
	ПараметрыСобытия = Новый Структура("Идентификатор, Результат", Идентификатор);
	ОсновнойМодуль().КонтурПлагины_ОбработатьСлужебнуюКоманду("Плагин_ПолучитьНастройки", ПараметрыСобытия);
	
	Если ПараметрыСобытия.Результат.Успешно Тогда
		Результат = ПараметрыСобытия.Результат.Данные;
	КонецЕсли;
	
    Возврат Результат;
	
КонецФункции // СохраненныеНастройкиПлагина()

&НаКлиенте
Процедура ЗаписатьНастройкиПлагина(Настройки, Отказ)
	
	Идентификатор = ИдентификаторПлагина();
	
	ПараметрыСобытия = Новый Структура("Идентификатор, Настройки, Результат", Идентификатор, Настройки);
	
	ОсновнойМодуль = ОсновнойМодуль();
	
	ОсновнойМодуль.КонтурПлагины_ОбработатьСлужебнуюКоманду("Плагин_СохранитьНастройки", ПараметрыСобытия);
	
КонецПроцедуры

&НаКлиенте
// Готовит настройки плагина для сохранения
Функция НастройкиПлагинаВСтруктуру()

	Результат = Новый Структура();
	
	Результат.Вставить("ПутьКАрхиву", ПутьКАрхиву);
	Результат.Вставить("ПрисоединятьКДокументу", ПрисоединятьКДокументу);
	Результат.Вставить("ПрисоединятьПечатныеФормыОтдельно", ПрисоединятьПечатныеФормыОтдельно);
	Результат.Вставить("ТекстОшибки", "");	
	Результат.Вставить("СписокТиповДокументов", СписокТиповДокументов);
	Результат.Вставить("СписокОрганизаций", СписокОрганизаций);
	Результат.Вставить("ИспользоватьРЗ", ИспользоватьРЗ);
	Результат.Вставить("СмещениеКоличествоМесяцев", СмещениеКоличествоМесяцев);
	Возврат Результат;

КонецФункции // НастройкиПлагинаВСтруктуру()

&НаСервере
// Отображает сохраненные настройки плагина на форме
Процедура ПрименитьНастройкиПлагинаНаФормеНаСервере(Настройки, ПараметрыСобытия)
	
	Если ТипЗнч(Настройки) = Тип("Структура") Тогда
				
		Настройки.Свойство("ПутьКАрхиву", ПутьКАрхиву);
		Настройки.Свойство("ИспользоватьРЗ", ИспользоватьРЗ);
		Настройки.Свойство("СмещениеКоличествоМесяцев", СмещениеКоличествоМесяцев);
		Настройки.Свойство("ПрисоединятьКДокументу", ПрисоединятьКДокументу);
		Настройки.Свойство("ПрисоединятьПечатныеФормыОтдельно", ПрисоединятьПечатныеФормыОтдельно);
		Настройки.Свойство("ТекстОшибки", ТекстОшибки);
		
		ПрисоединятьПечатныеФормыОтдельно = СвойствоСтруктурыЛокальная(Настройки, "ПрисоединятьПечатныеФормыОтдельно", ПрисоединятьКДокументу);
		
		Настройки.Свойство("СписокОрганизаций", СписокОрганизаций);
		Если СписокОрганизаций.Количество() = 0 Тогда
			СписокОрганизаций = СписокОрганизацийПоУмолчанию(ПараметрыСобытия);
		КонецЕсли;
		
		Настройки.Свойство("СписокТиповДокументов", СписокТиповДокументов);
		Если СписокТиповДокументов.Количество() = 0 Тогда
			СписокТиповДокументов = МодульОбъекта().ТипыДокументовДляВыгрузкиПоУмолчанию();
		КонецЕсли;
		
	Иначе
		ЗаполнитьФормуНастройкамиПоУмолчанию(ПараметрыСобытия);	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборКаталогаАрхива(ВыбранныйКаталог, ДополнительныеПараметры) Экспорт
	Если ВыбранныйКаталог = Неопределено Тогда
   		Возврат;
    КонецЕсли;
	
	ПутьКАрхиву = ВыбранныйКаталог[0];
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьНастройкиПередЗаписью(Настройки, Отказ)
	
	ПроверитьДоступностьКаталогаАрхива(Настройки.ПутьКАрхиву, Отказ);
	ПроверитьВыбранныеОрганизации(Настройки.СписокОрганизаций, Отказ);
	ПроверитьВыбранныеТипыДокументов(Настройки.СписокТиповДокументов, Отказ);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьДоступностьКаталогаАрхива(ПутьККаталогу, Отказ)
	
	ПараметрыСобытия = Новый Структура;
	ПараметрыСобытия.Вставить("Каталог", ПутьККаталогу);
	
	ОсновнойМодуль = ОсновнойМодуль();
	
	РезультатПроверки = ОсновнойМодуль.ПодключаемыйМодуль_ОбработатьСобытие(
		"Плагин_СохранениеДокументов_ПроверитьДоступностьКаталога",
		ПараметрыСобытия
	);
	
	Если РезультатПроверки.ЕстьОшибки Тогда
		
		Сообщить(РезультатПроверки.ТекстОшибки);
		
		Отказ = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВыбранныеОрганизации(СписокОрганизаций, Отказ)
	
	ВыбранныеОрганизации = ПомеченныеЭлементыСпискаВМассив(СписокОрганизаций);
	
	Если ВыбранныеОрганизации.Количество() = 0 Тогда
		
		ТекстПредупреждения = НСтр("ru='Необходимо выбрать хотя бы одно значение на закладке ""Организации""'");
		
		ПоказатьПредупреждение(
			Неопределено,
			ТекстПредупреждения
		);
		
		Отказ = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВыбранныеТипыДокументов(СписокТиповДокументов, Отказ)
	
	ВыбранныеТипыДокументов = ПомеченныеЭлементыСпискаВМассив(СписокТиповДокументов);
	
	Если ВыбранныеТипыДокументов.Количество() = 0 Тогда
		
		ТекстПредупреждения = НСтр("ru='Необходимо выбрать хотя бы одно значение на закладке ""Типы документов""'");
		
		ПоказатьПредупреждение(
			Неопределено,
			ТекстПредупреждения
		);
		
		Отказ = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

// } РАБОТА С НАСТРОЙКАМИ

// { ПРОЧИЕ

&НаКлиенте
Процедура ОбновитьПредставлениеПериода()
	
	ДатаОкончания = ОкончаниеПериодаОбработки();
	
	Элементы.НадписьПредставлениеПериода.Заголовок =
		ПредставлениеПериода(НачалоДня(ДобавитьМесяц(ДатаОкончания, -СмещениеКоличествоМесяцев)), КонецДня(ДатаОкончания), "ФП=Истина") 
	
КонецПроцедуры

&НаСервере
Функция СписокОрганизацийПоУмолчанию(ПараметрыСобытия)
	
	Результат = Новый СписокЗначений;
	
	СписокДоступныхОрганизаций = ЗначениеИзСтрокиВнутр(ПараметрыСобытия.Результат);
	Если ЗначениеЗаполнено(СписокДоступныхОрганизаций) Тогда
		Результат.ЗагрузитьЗначения(СписокДоступныхОрганизаций);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьФормуНастройкамиПоУмолчанию(ПараметрыСобытия)
	
	СписокТиповДокументов = МодульОбъекта().ТипыДокументовДляВыгрузкиПоУмолчанию();
	СписокОрганизаций = СписокОрганизацийПоУмолчанию(ПараметрыСобытия);
	СмещениеКоличествоМесяцев = 1;
	ИспользоватьРЗ = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьЭлементаПрисоедиятьПФОтдельно()
	
	Элементы.ПрисоединятьПечатныеФормыОтдельно.Доступность = ПрисоединятьКДокументу;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВидимость()
	Элементы.ГруппаОповещения.Видимость = ЗначениеЗаполнено(ТекстОшибки);
КонецПроцедуры

&НаКлиенте
Процедура ОтметкаСписка(Результат, Параметры) Экспорт
 
    Если Не Результат = Неопределено Тогда
		Если Результат = "*********" Тогда
			СписокОрганизаций[Параметры.ТекущаяСтрока].Пометка = Истина;
		Иначе
			ПоказатьПредупреждение(Неопределено, "Неверный ключ организациии");
		КонецЕсли;
    КонецЕсли;
 
КонецПроцедуры


// } ПРОЧИЕ

// { СЛУЖЕБНЫЕ

&НаКлиентеНаСервереБезКонтекста
Функция СвойствоСтруктурыЛокальная(Структура, ИмяСвойства, ЗначениеПоУмолчанию = Неопределено)
	
	Результат = ЗначениеПоУмолчанию;
	Если Структура.Свойство(ИмяСвойства) Тогда
		Результат = Структура[ИмяСвойства]
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция ИдентификаторПлагина()
	
	Манифест = МодульОбъекта().МанифестПлагина();
	Возврат Манифест.Идентификатор;
	
КонецФункции

&НаСервереБезКонтекста
Функция ОкончаниеПериодаОбработки()
	
	Возврат ТекущаяДата();
	
КонецФункции

&НаКлиенте
Функция ПомеченныеЭлементыСпискаВМассив(СписокЗначений)

	Результат = Новый Массив;
	
	Для Каждого ЭлементСписка Из СписокЗначений Цикл
		Если ЭлементСписка.Пометка Тогда
			Результат.Добавить(ЭлементСписка.Значение);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// } СЛУЖЕБНЫЕ
