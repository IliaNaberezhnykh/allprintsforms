Функция СведенияОВнешнейОбработке()Экспорт
	
	ПараметрыРегистрации = Новый Структура;
	МассивНазначений = Новый Массив;
	МассивНазначений.Добавить("Документ.ВнутреннееПотребление");
	ПараметрыРегистрации.Вставить("Вид", "ПечатнаяФорма");
	ПараметрыРегистрации.Вставить("Назначение", МассивНазначений);
	ПараметрыРегистрации.Вставить("Наименование", "ОИР Накладная на отпуск материалов (М-15)"); 
	ПараметрыРегистрации.Вставить("БезопасныйРежим", ЛОЖЬ);
	ПараметрыРегистрации.Вставить("Версия", "2.0"); 
	ПараметрыРегистрации.Вставить("Информация", "ОИР Накладная на отпуск материалов (М-15)"); 
	ТаблицаКоманд = ПолучитьТаблицуКоманд();
	ДобавитьКоманду(ТаблицаКоманд, "ОИР Накладная на отпуск материалов (М-15)", "ПечатьНакладная", "ВызовСерверногоМетода", Истина, "ПечатьMXL");
	ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

Функция ПолучитьТаблицуКоманд()
	
	Команды = Новый ТаблицаЗначений;
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка")); 
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка")); 
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));
	Возврат Команды;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")
	
	НоваяКоманда = ТаблицаКоманд.Добавить();
	НоваяКоманда.Представление = Представление; 
	НоваяКоманда.Идентификатор = Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
	НоваяКоманда.Модификатор = Модификатор;
	
КонецПроцедуры
	
Процедура Печать(МассивОбъектов, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
		
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, 
		"ПечатьНакладная", "Печать Накладная",СформироватьПФ(МассивОбъектов[0], ОбъектыПечати)); 
		
КонецПроцедуры
	
Функция СформироватьПФ(СсылкаНаДокумент, ОбъектПечати) Экспорт 
	КолВоСтрок = 0;
	ТабличныйДокумент = Новый ТабличныйДокумент;
	ТабличныйДокумент.ИмяПараметровПечати = "ПАРАМЕТРЫ ПЕЧАТИ"; 
	МакетОбработки  = ПолучитьМакет("ПечатьНакладная"); 
	ТабличныйДокумент.Очистить();                     

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ВнутреннееПотребление.Товары.(
	|		Характеристика КАК Характеристика,
	|		Серия КАК Серия,
	|		Упаковка КАК ЕдИзмУпаковка,
	|		Количество КАК КолВоРасчет,
	|		СтатьяРасходов КАК СтатьяРасходов,
	|		ФизическоеЛицо КАК ФизическоеЛицо,
	|		ИнвентарныйНомер КАК ИнвентарныйНомер,
	|		ОсновноеСредство КАК ОсновноеСредство,
	|		НастройкаСчетовУчета КАК НастройкаСчетовУчета,
	|		ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление,
	|		Номенклатура.ЕдиницаИзмерения КАК ЕдИзм,
	|		Номенклатура.Наименование КАК Номенклатура,
	|		Номенклатура.Код КАК КодУчета,
	|		Номенклатура.Артикул КАК НоменклНомер,
	|		Номенклатура.ЕдиницаИзмерения.Код КАК КодЕдИзм,
	|		Номенклатура.ГруппаФинансовогоУчета.Описание КАК ГруппаФинансовогоУчета
	|	) КАК Товары,
	|	ВнутреннееПотребление.Ссылка КАК Ссылка,
	|	ВнутреннееПотребление.Организация.КонтактнаяИнформация.(
	|		Представление КАК Представление,
	|		Тип КАК Тип,
	|		Вид КАК Вид
	|	) КАК Организация,
	|	ВнутреннееПотребление.Организация.Наименование КАК ОрганизацияНаименование,
	|	ВнутреннееПотребление.Организация.ИНН КАК ОрганизацияИНН,
	|	ВнутреннееПотребление.Склад.Наименование КАК СкладОтправитель,
	|	ВнутреннееПотребление.Номер КАК Номер,
	|	ВнутреннееПотребление.Дата КАК ДатаСоставления
	|ИЗ
	|	Документ.ВнутреннееПотребление КАК ВнутреннееПотребление
	|ГДЕ
	|	ВнутреннееПотребление.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(ОтветственныеЛицаОрганизаций.ФизическоеЛицо.Наименование) КАК ГлавБух
	|ИЗ
	|	Справочник.ОтветственныеЛицаОрганизаций КАК ОтветственныеЛицаОрганизаций
	|ГДЕ
	|	ОтветственныеЛицаОрганизаций.ПометкаУдаления = ЛОЖЬ
	|	И ОтветственныеЛицаОрганизаций.ДатаОкончания >= &ДатаОкончания
	|	И ОтветственныеЛицаОрганизаций.ДолжностьСсылка.Наименование = ""Главный бухгалтер""";   
	
	Запрос.УстановитьПараметр("Ссылка", СсылкаНаДокумент);
	Запрос.УстановитьПараметр("ДатаОкончания", СсылкаНаДокумент.Дата);  
	
	ВыборкаЗаписиМассив = Запрос.ВыполнитьПакет();
	
	Результат = ВыборкаЗаписиМассив[0];
	РезультатГлавБух = ВыборкаЗаписиМассив[1]; 
	
	Выборка =  Результат.Выбрать();
	ВыборкаГлавБух  =  РезультатГлавБух.Выбрать();
	
	ОбластьШапка = МакетОбработки.ПолучитьОбласть("Шапка");
	ОбластьШапка2 = МакетОбработки.ПолучитьОбласть("Шапка2");
	ОбластьШапкаТаблицы = МакетОбработки.ПолучитьОбласть("ШапкаТаблицы"); 
	ОбластьТаблица = МакетОбработки.ПолучитьОбласть("Таблица");
	ОбластьПодвал = МакетОбработки.ПолучитьОбласть("Подвал");
	
	Пока Выборка.Следующий() Цикл
		ВыборкаОрг    = Выборка.Организация.Выбрать();
		ВыборкаТовары = Выборка.Товары.Выбрать();
		
		ОбластьШапка.Параметры.Заполнить(Выборка);
		
		Пока ВыборкаОрг.Следующий() Цикл
			 Если ВыборкаОрг.Тип = Перечисления.ТипыКонтактнойИнформации.Адрес И ВыборкаОрг.Вид.Наименование = "Юридический адрес" Тогда
				  Адрес = ВыборкаОрг.Представление;
			 КонецЕсли;
			 Если ВыборкаОрг.Тип = Перечисления.ТипыКонтактнойИнформации.Телефон  Тогда
				  Телефон = ВыборкаОрг.Представление;
			 КонецЕсли; 
			 ОбластьШапка.Параметры.Организация = Выборка.ОрганизацияНаименование + ", ИНН " + Выборка.ОрганизацияИНН + " , " + Адрес + ", тел.:" + Телефон; 
		КонецЦикла;      
		 
		ТабличныйДокумент.Вывести(ОбластьШапка);
		
		ОбластьШапка2.Параметры.Заполнить(Выборка); 
		ТабличныйДокумент.Вывести(ОбластьШапка2);
		
		ТабличныйДокумент.Вывести(ОбластьШапкаТаблицы); 
		
		Пока ВыборкаТовары.Следующий() Цикл
			 КолВоСтрок = КолВоСтрок + 1;
			 ОбластьТаблица.Параметры.Заполнить(ВыборкаТовары);
			 Если ПустаяСтрока(ВыборкаТовары.ЕдИзм) Тогда
				   ОбластьТаблица.Параметры.ЕдИзм = ВыборкаТовары.ЕдИзмУпаковка;
			 КонецЕсли;
			 Счет = ВыборкаТовары.ГруппаФинансовогоУчета; 
			 Позиция = Найти(Счет,"ч") + 1;
			 ЧислоСимвол = СтрДлина(Счет) - Позиция; 
			 Текст = Прав(Счет,ЧислоСимвол);
			 
			 Если Найти(Текст,",") <> 0 Тогда 
			      ПозицияД = Найти(Текст,",") - 1;
			      ТекстД = Лев(Текст,ПозицияД);
			      ОбластьТаблица.Параметры.Счет = ТекстД; 
			 Иначе 
				  ОбластьТаблица.Параметры.Счет = Текст; 
			 КонецЕсли;
			 ТабличныйДокумент.Вывести(ОбластьТаблица); 
		 КонецЦикла;
		 ОбластьПодвал.Параметры.Отпущено = ЧислоПрописью(КолВоСтрок, "Л=ru_RU;НП=Ложь", ",,,,,,,,0"); 
	КонецЦикла;
	Пока ВыборкаГлавБух.Следующий() Цикл
		 ОбластьПодвал.Параметры.ГлавБух = ВыборкаГлавБух.ГлавБух;
	КонецЦикла;
	 
	ТабличныйДокумент.Вывести(ОбластьПодвал); 

    ТабличныйДокумент.АвтоМасштаб = Истина; 
    Возврат ТабличныйДокумент;

КонецФункции