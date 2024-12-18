//{		Сервисные методы

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
Функция Модуль_ЯдроНаСервере()
	
	Результат = ОбработкаОбъект().Модуль_Ядро();
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция ОбработкаОбъект()
	
	Результат = РеквизитФормыВЗначение("Объект");
	Возврат Результат;
	
КонецФункции

//}		Сервисные методы


//{		ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СценарийДляОтзыва = Параметры.Сценарий;
	
	НастроитьФормуПоСценариюДляОтзыва();
	ИнициализироватьИдентификаторТрассировки();
	
КонецПроцедуры

//}		ОбработчикиСобытийФормы


//{		ОбработчикиКомандФормы

&НаКлиенте
Процедура ОставитьОтзыв(Команда)
	
	Метрики_ЗаписатьНажатие_ОставитьОтзыв();
	
	Закрыть(Отзыв);
	
КонецПроцедуры

&НаКлиенте
Процедура Отменить(Команда)
	
	Метрики_ЗаписатьНажатие_Отменить();
	
	Закрыть(Неопределено);
	
КонецПроцедуры

//}		ОбработчикиКомандФормы


//{		СлужебныеПроцедурыИФункции

&НаСервере
Процедура НастроитьФормуСценарийРаботаСКонтрагентами()
	
	ЭтаФорма.Заголовок = Нстр("ru = 'Отзыв о работе с контрагентами'");
	Элементы.ДекорацияСопроводительныйТекст.Заголовок =
		Нстр("ru = 'Мы не хотели вас расстраивать. Поделитесь трудностями, с которыми вы столкнулись. Это поможет сделать наш модуль лучше.'");
	
	Метрика_НаименованиеФормы = "ОтзывОРаботеСКонтрагентами";
	Метрика_Категория = "ТрудностиСКонтрагентами";
	Метрика_Представление = "ОтзывОРаботеСКонтрагентами";
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуСценарийОплатаСервиса()
	
	ЭтаФорма.Заголовок = Нстр("ru = 'Отзыв о работе с предложениями об оплате'");
	Элементы.ДекорацияСопроводительныйТекст.Заголовок =
		Нстр("ru = 'Мы не хотели вас расстраивать. Поделитесь трудностями, с которыми вы столкнулись. Это поможет сделать наш модуль лучше.'");
	
	Метрика_НаименованиеФормы = "ОтзывОРаботеСОнлайнами";
	Метрика_Категория = "ТрудностиСОнлайнПредложениями";
	Метрика_Представление = "ОтзывПоПредложениямОбОплате";
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуСценарийПоискДокументовНаОтправку()
	
	ЭтаФорма.Заголовок = НСтр("ru = 'Отзыв об инструменте поиска документов'");
	Элементы.ДекорацияСопроводительныйТекст.Заголовок =
		НСтр("ru = 'Мы не хотели вас расстраивать. Поделитесь трудностями, с которыми вы столкнулись. Это поможет сделать наш модуль лучше.'");
	
	Метрика_НаименованиеФормы = "ОтзывПоПоискуДокументов";
	Метрика_Категория = "ТрудностиПриПоискеДокументов";
	Метрика_Представление = "ОтзывПоПоискуДокументов";
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПоСценариюДляОтзыва()
	
	Модуль_Ядро = Модуль_ЯдроНаСервере();
	
	СценарииМодуля = Модуль_Ядро.Перечисление_СценарииМодуляДляОтзывов();
	
	Если СценарийДляОтзыва = СценарииМодуля.РаботаСКонтрагентами Тогда
		
		НастроитьФормуСценарийРаботаСКонтрагентами();
		
	ИначеЕсли СценарийДляОтзыва = СценарииМодуля.ОплатаСервиса Тогда
		
		НастроитьФормуСценарийОплатаСервиса();
		
	ИначеЕсли СценарийДляОтзыва = СценарииМодуля.ПоискДокументовНаОтправку Тогда
		
		НастроитьФормуСценарийПоискДокументовНаОтправку();
		
	Иначе
		
		Ошибка = СтрЗаменить(
				"Неожиданное значение параметра ""Сценарий"" (%1)",
				"%1",
				СценарииМодуля
			);
		
		ВызватьИсключение Ошибка;
		
	КонецЕсли;
	
КонецПроцедуры

//}		СлужебныеПроцедурыИФункции


//{		Метрики

&НаКлиенте
Процедура Метрики_ЗаписатьНажатие_ОставитьОтзыв()
	
	Ядро = Модуль_ЯдроНаКлиенте();
	
	Действие = "ОтправитьОтзыв";
	Метка = "Нажатие кнопки";
	Переменные = Неопределено;
	ДобавитьСистемнуюИнформацию = Истина;
	
	Ядро.Метрика_ЗаписатьПоведение(
		Метрика_Категория,
		Действие,
		Метрика_Представление,
		Метка,
		Переменные,
		ДобавитьСистемнуюИнформацию,
		ИдентификаторТрассировки);
	
КонецПроцедуры

&НаКлиенте
Процедура Метрики_ЗаписатьНажатие_Отменить()
	
	Ядро = Модуль_ЯдроНаКлиенте();
	
	Действие = "Отменить";
	Метка = "Нажатие кнопки";
	Переменные = Неопределено;
	ДобавитьСистемнуюИнформацию = Истина;
	
	Ядро.Метрика_ЗаписатьПоведение(
		Метрика_Категория,
		Действие,
		Метрика_Представление,
		Метка,
		Переменные,
		ДобавитьСистемнуюИнформацию,
		ИдентификаторТрассировки);
	
КонецПроцедуры

&НаСервере
Процедура ИнициализироватьИдентификаторТрассировки()
	
	СтрокаИдентификатора = Строка(Новый УникальныйИдентификатор());
	ИдентификаторТрассировки = Метрика_НаименованиеФормы + "_" + СтрокаИдентификатора;
	
КонецПроцедуры

//}		Метрики