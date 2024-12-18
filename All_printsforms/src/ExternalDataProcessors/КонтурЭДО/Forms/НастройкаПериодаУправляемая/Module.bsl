
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
Процедура ИнициализироватьФорму(Параметры) Экспорт
	
	ДатаНачала					= Параметры.НастройкаПериода.ДатаНачала;
	ДатаОкончания				= Параметры.НастройкаПериода.ДатаОкончания;
	РежимОтбораПоПериоду		= Параметры.НастройкаПериода.РежимОтбораПоПериоду;
	РежимОтображенияДокументов	= Параметры.РежимОтображенияДокументов;
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	НастройкиВыбораПериода = ОбработкаОбъект.ПользовательскиеНастройкиПериодаПрочитать();
	ВыборПериодаПриЗапуске = НастройкиВыбораПериода.ВариантВыбораПериода;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ИнициализироватьФорму(Параметры);
	
	ЗаполнитьСписокВыбораПериода();
	
	ЗаполнитьСписокВыбораПериодаПриЗапуске();
	
	НастроитьЭлементыФормы();
	
	УстановитьЗаголовокФормы();
	
	ЗаполнитьСписокВыбораГода();
	
	ОпределитьТипИнтервала();
	
	КлючСохраненияПоложенияОкна = Новый УникальныйИдентификатор();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьСтраницуПанелиВыбораПериода();
	
КонецПроцедуры

&НаСервере
Процедура НастроитьЭлементыФормы()
	
	Если РежимОтображенияДокументов = "ОтправкаПакетов" Тогда
		
		Элементы.РежимОтбораПоПериоду.Видимость = Ложь;
		
	Иначе
		
		ЗаполнитьСписокРежимовОтбора();
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокРежимовОтбора()
	
	СписокРежимовОтбора = Новый СписокЗначений;
	СписокРежимовОтбора.Добавить("ПоДатеОтправкиИлиПолучения", ?(РежимОтображенияДокументов = "ОтправленныеДокументы",
																							"Дата отправки", "Дата получения"));
	СписокРежимовОтбора.Добавить("ПоДатеДокумента", "Дата документа");
	
	СписокВыбораРежимовОтбора = Элементы.РежимОтбораПоПериоду.СписокВыбора;
	ЗаполнитьСписокВыбораЭлементаФормы(СписокВыбораРежимовОтбора, СписокРежимовОтбора)
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокВыбораГода()
	
	СписокГодов = СписокВыбораГода();
	ЗаполнитьСписокВыбораЭлементаФормы(Элементы.Месяц_Год.СписокВыбора, 	СписокГодов);
	ЗаполнитьСписокВыбораЭлементаФормы(Элементы.Квартал_Год.СписокВыбора, 	СписокГодов);
	ЗаполнитьСписокВыбораЭлементаФормы(Элементы.Год.СписокВыбора, 			СписокГодов);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокВыбораПериода()
	
	ЭлементВыборПериода = Элементы.ВыборПериода.СписокВыбора;
	
	СтруктураВыбораПериода = ВариантыВыбораПериода();
	
	Для Каждого ЭлементСтруктурыВыбораПериода Из СтруктураВыбораПериода Цикл
		ЭлементВыборПериода.Добавить(ЭлементСтруктурыВыбораПериода.Значение);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокВыбораПериодаПриЗапуске()
	
	ЭлементВыборПериодаПриЗапуске = Элементы.ВыборПериодаПриЗапуске.СписокВыбора;
	
	ЭлементВыборПериодаПриЗапуске.Добавить(ВариантСтандартногоПериода.Сегодня, "Текущий день");
	ЭлементВыборПериодаПриЗапуске.Добавить(ВариантСтандартногоПериода.ЭтаНеделя, "Текущая неделя");
	ЭлементВыборПериодаПриЗапуске.Добавить(ВариантСтандартногоПериода.ЭтотМесяц, "Текущий месяц");
	ЭлементВыборПериодаПриЗапуске.Добавить(ВариантСтандартногоПериода.ЭтотКвартал, "Текущий квартал");
	ЭлементВыборПериодаПриЗапуске.Добавить(ВариантСтандартногоПериода.ЭтотГод, "Текущий год");
	
КонецПроцедуры

&НаСервере
Процедура УстановитьЗаголовокФормы()
	
	Если РежимОтображенияДокументов <> "ОтправкаПакетов" Тогда
		ЭтаФорма.Заголовок = "Дата документа";
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьДаты(Элемент)
	
	РассчитатьДатыНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура РассчитатьДатыНаСервере() 
	
	ВариантИнтервала = ВариантыВыбораПериода();
	
	Если ВыборПериода = ВариантИнтервала.День Тогда 
		
		Если Не ЗначениеЗаполнено(День) Тогда
			День = ТекущаяДата();
		КонецЕсли;
		
		ДатаНачала		= НачалоДня(День);
		ДатаОкончания	= КонецДня(День);
	
	ИначеЕсли ВыборПериода = ВариантИнтервала.Месяц Тогда
		
		Если НЕ ЗначениеЗаполнено(Год) Тогда
			Год = Год_ПоУмолчанию(ДатаОкончания);
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Месяц) Тогда
			Месяц = Месяц_ПоУмолчанию(ДатаОкончания);
		КонецЕсли;
		
		ДатаНачала		= Дата(Год, Месяц, 1);
		ДатаОкончания	= КонецМесяца(ДатаНачала);
		
	ИначеЕсли ВыборПериода = ВариантИнтервала.Квартал Тогда
		
		Если НЕ ЗначениеЗаполнено(Год) Тогда
			Год = Год_ПоУмолчанию(ДатаОкончания);
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Квартал) Тогда
			Квартал = Квартал_ПоУмолчанию(ДатаОкончания);
		КонецЕсли;
		
		ДатаОкончания	= КонецКвартала(Дата(Год, Квартал * 3, 1));
		ДатаНачала		= НачалоКвартала(ДатаОкончания);
		
	ИначеЕсли ВыборПериода = ВариантИнтервала.Год Тогда
		
		Если НЕ ЗначениеЗаполнено(Год) Тогда
			Год = Год_ПоУмолчанию(ДатаОкончания);
		КонецЕсли;
		
		ДатаНачала		= НачалоГода(Дата(Год, 1, 1));
		ДатаОкончания	= КонецГода(ДатаНачала);
		
	Иначе
		
		ДатаНачала		= Интервал_ДатаНачала;
		ДатаОкончания	= ?(ЗначениеЗаполнено(Интервал_ДатаОкончания), КонецДня(Интервал_ДатаОкончания), Интервал_ДатаОкончания);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Применить(Команда)
	
	ПрименитьПериод();
	
КонецПроцедуры

&НаКлиенте
Процедура ПрименитьПериод()
	
	Если ДатаОкончания < ДатаНачала Тогда
		
		ТекстОшибки = "Дата начала периода не может быть больше даты конца периода";
		ОсновнаяФорма().ПоказатьПредупреждениеПереопределенная(, ТекстОшибки, , "Неверно задан интервал");
		Возврат;
		
	КонецЕсли;
	
	Метрики_ЗаписатьУстановку_НастройкиПериода();
	
	Результат = Новый Структура;
	Результат.Вставить("ДатаНачала",			ДатаНачала);
	Результат.Вставить("ДатаОкончания",			ДатаОкончания);
	Результат.Вставить("РежимОтбораПоПериоду",	РежимОтбораПоПериоду);
	
	Платформа = ОсновнаяФорма().Модуль_Платформа();
	Платформа.ПользовательскиеНастройкиПериодаУстановить(
		ВыборПериодаПриЗапуске,
		РежимОтбораПоПериоду
	);
	
	Закрыть(Результат);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ЗаполнитьСписокВыбораЭлементаФормы(СписокВыбораЭлементаФормы, Источник)
	
	СписокВыбораЭлементаФормы.Очистить();
	Для Каждого ЭлементСЗ Из Источник Цикл
		СписокВыбораЭлементаФормы.Добавить(ЭлементСЗ.Значение, ЭлементСЗ.Представление);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСтраницуПанелиВыбораПериода()
	
	ВариантИнтервала = ВариантыВыбораПериода();
	
	Если НЕ ЗначениеЗаполнено(ДатаОкончания) 
		И ВыборПериода <> ВариантИнтервала.Интервал Тогда
		ДатаОкончания = ТекущаяДата();
	КонецЕсли;
	
	Если ВыборПериода = ВариантИнтервала.День Тогда
		
		ТекущаяСтраницаПанели = Элементы.ГруппаДень;
		
		День = ДатаОкончания;
		
	ИначеЕсли ВыборПериода = ВариантИнтервала.Месяц Тогда
		
		ТекущаяСтраницаПанели = Элементы.ГруппаМесяц;
		
		Месяц	= Месяц_ПоУмолчанию(ДатаОкончания);
		Год		= Год_ПоУмолчанию(ДатаОкончания);
		
	ИначеЕсли ВыборПериода = ВариантИнтервала.Квартал Тогда
		
		ТекущаяСтраницаПанели = Элементы.ГруппаКвартал;
		
		Квартал	= Квартал_ПоУмолчанию(ДатаОкончания);
		Год		= Год_ПоУмолчанию(ДатаОкончания);
		
	ИначеЕсли ВыборПериода = ВариантИнтервала.Год Тогда
		
		ТекущаяСтраницаПанели = Элементы.ГруппаГод;
		
		Год = Год_ПоУмолчанию(ДатаОкончания);
		
	Иначе
		
		ТекущаяСтраницаПанели = Элементы.ГруппаИнтервал;
		
		Интервал_ДатаНачала		= ДатаНачала;
		Интервал_ДатаОкончания	= ДатаОкончания;
		
	КонецЕсли;
	
	Элементы.ПанельВыбораПериода.ТекущаяСтраница = ТекущаяСтраницаПанели;
	
	РассчитатьДатыНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ОпределитьТипИнтервала()
	
	ВариантИнтервала = ВариантыВыбораПериода();
	
	Если ДатаНачала = ДатаОкончания Тогда
		
		ВыборПериода = ВариантИнтервала.День;
		
	ИначеЕсли ДатаНачала = НачалоМесяца(ДатаОкончания)
		И ДатаОкончания = НачалоДня(КонецМесяца(ДатаОкончания)) Тогда
		
		ВыборПериода = ВариантИнтервала.Месяц;
		
	ИначеЕсли ДатаНачала = НачалоКвартала(ДатаОкончания)
		И ДатаОкончания = НачалоДня(КонецКвартала(ДатаОкончания)) Тогда
		
		ВыборПериода = ВариантИнтервала.Квартал;
		
	ИначеЕсли ДатаНачала = НачалоГода(ДатаОкончания)
		И ДатаОкончания = НачалоДня(КонецГода(ДатаОкончания)) Тогда
		
		ВыборПериода = ВариантИнтервала.Год;
		
	Иначе
		
		ВыборПериода = ВариантИнтервала.Интервал;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция СписокВыбораГода()
	
	Результат = Новый СписокЗначений;
	
	ГодЧисло = Год(ТекущаяДата());
	
	Для сц = ГодЧисло - 10 По ГодЧисло + 1 Цикл
		Результат.Добавить(сц, Формат(сц, "ЧГ=0"));
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция Год_ПоУмолчанию(ДатаОкончания)
	
	Результат = Год(ДатаОкончания);
	
	Возврат Результат;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция Месяц_ПоУмолчанию(ДатаОкончания)
	
	Результат = Месяц(ДатаОкончания);
	
	Возврат Результат;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция Квартал_ПоУмолчанию(ДатаОкончания)
	
	Результат = Окр(Месяц(ДатаОкончания) / 3 + 0.49);
	
	Возврат Результат;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ВариантыВыбораПериода()
	
	Результат = Новый Структура;
	
	Результат.Вставить("День", 		"День");
	Результат.Вставить("Месяц", 	"Месяц");
	Результат.Вставить("Год",		"Год");
	Результат.Вставить("Квартал", 	"Квартал");
	Результат.Вставить("Интервал",	"Интервал");
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ВыборПериодаПриИзменении(Элемент)
	
	Метрики_ЗаписатьИзменение_ПериодОтбора();
	
	ОбновитьСтраницуПанелиВыбораПериода();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборПериодаПриЗапускеПриИзменении(Элемент)
	
	Метрики_ЗаписатьИзменение_ПериодПриЗапуске();
	
КонецПроцедуры

&НаКлиенте
Процедура Метрики_ЗаписатьИзменение_ПериодОтбора()
	
	НазваниеФормы		= Метрика_НазваниеФормы();
	КатегорияМетрики	= ОсновнаяФорма().Метрика_НазваниеКатегории().Фильтры;
	ДействиеМетрики		= "Сменить период";
	
	Ядро = Модуль_ЯдроНаКлиенте();
	
	Ядро.Метрика_ДобавитьПоведение_НажатиеКнопки(НазваниеФормы, КатегорияМетрики, ДействиеМетрики);
	
	Переменные = Новый Соответствие;
	Переменные.Вставить("Значение", ВыборПериода);
	
	Ядро.Метрика_ДобавитьСтатистику_ПоКонтексту(КатегорияМетрики, ДействиеМетрики, , Переменные);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрики_ЗаписатьИзменение_ПериодПриЗапуске()
	
	НазваниеФормы		= Метрика_НазваниеФормы();
	КатегорияМетрики	= ОсновнаяФорма().Метрика_НазваниеКатегории().Фильтры;
	ДействиеМетрики		= "ДатаДляЗапуска";
	
	Ядро = Модуль_ЯдроНаКлиенте();
	
	Ядро.Метрика_ДобавитьПоведение_НажатиеКнопки(НазваниеФормы, КатегорияМетрики, ДействиеМетрики);
	
	Переменные = Новый Соответствие;
	Переменные.Вставить("Значение", Элементы.ВыборПериодаПриЗапуске.ВыделенныйТекст);
	
	Ядро.Метрика_ДобавитьСтатистику_ПоКонтексту(КатегорияМетрики, ДействиеМетрики, , Переменные);

КонецПроцедуры

&НаКлиенте
Процедура Метрики_ЗаписатьУстановку_НастройкиПериода()
	
	НазваниеФормы		= Метрика_НазваниеФормы();
	КатегорияМетрики	= ОсновнаяФорма().Метрика_НазваниеКатегории().Фильтры;
	ДействиеМетрики		= "Применить";
	
	Ядро = Модуль_ЯдроНаКлиенте();
	
	Ядро.Метрика_ДобавитьПоведение_НажатиеКнопки(НазваниеФормы, КатегорияМетрики, ДействиеМетрики);
	
	Переменные = Новый Соответствие;
	Переменные.Вставить("Значение", ВыборПериода);
	Переменные.Вставить("РежимОтбора", РежимОтбораПоПериоду);
	Переменные.Вставить("ДатаДляЗапуска", Элементы.ВыборПериодаПриЗапуске.ВыделенныйТекст);
	
	Ядро.Метрика_ДобавитьСтатистику_ПоКонтексту(КатегорияМетрики, ДействиеМетрики, , Переменные);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция Метрика_НазваниеФормы()
	
	Результат = "Форма даты";
	Возврат Результат;
	
КонецФункции
