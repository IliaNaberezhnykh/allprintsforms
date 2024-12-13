
&НаКлиенте
Перем МестныйКэш Экспорт;//aa.uferov добавлена переменная на формы сопоставления номенклатуры. Для работы через внешний интерфейс, когда не удаётся найти главное окно с инициированным кэшем.

// Получает номенклатуру 1С по структуре контрагента и номенклатуры СБИС. Вызывает функцию поиска номенклатуры на сервере 
&НаКлиенте
Функция НайтиНоменклатуруПоставщикаПоТабличнойЧасти(стрКонтрагент, знач мТаблДок, КаталогНастроек, Ини) Экспорт
	СчетчикСтрок	= 0;
	СтрокиПоиска	= Новый Структура;
	Для Каждого СтрТабл Из мТаблДок Цикл
		СтрокаПоиска = Новый Структура;
		Если СтрТабл.Свойство("Название") Тогда
			СтрокаПоиска.Вставить("Название",		СтрТабл.Название);
		КонецЕсли;
		Если СтрТабл.Свойство("КодПокупателя") Тогда
			СтрокаПоиска.Вставить("КодПокупателя",	СтрТабл.КодПокупателя);
		КонецЕсли;
		Если СтрТабл.Свойство("Идентификатор") Тогда
			СтрокаПоиска.Вставить("Идентификатор",	СтрТабл.Идентификатор);
		КонецЕсли;
		Если Не ЗначениеЗаполнено(СтрокаПоиска) Тогда
			ВызватьИсключение("НайтиНоменклатуруПоставщикаПоТабличнойЧасти() Отсутствует название и идентификатор номенклатуры для поиска в строке №" + (СчетчикСтрок+1));
		КонецЕсли;
		СтрокиПоиска.Вставить("СтрТабл_"+Формат(СчетчикСтрок, "ЧН=0; ЧГ=0"),СтрокаПоиска);
		СчетчикСтрок = СчетчикСтрок + 1;
	КонецЦикла;
	
	Возврат НайтиНоменклатуруПоставщикаПоТабличнойЧастиНаСервере(стрКонтрагент, СтрокиПоиска, КаталогНастроек, Ини.Конфигурация);
КонецФункции

&НаСервереБезКонтекста
Функция НайтиНоменклатуруПоставщикаПоТабличнойЧастиНаСервере(стрКонтрагент,стрНоменклатураПоставщикаВсе, КаталогНастроек, ИниКонфигурация) Экспорт
// ищет запись с определенной номенклатурой поставщика по реквизитам, указанным в файле настроек
// возвращает структуру с полями Номенклатура и Характеристика	
	Результат = НайтиНоменклатуруПоставщикаНаСервере(ИниКонфигурация);
	Для Каждого стрНоменклатураПоставщика Из стрНоменклатураПоставщикаВсе Цикл	
		стрНоменклатураПоставщика.Значение.Вставить("НоменклатураПоставщика",Результат);	
	КонецЦикла;
	Возврат стрНоменклатураПоставщикаВсе; 
КонецФункции
&НаКлиенте
Функция НайтиНоменклатуруПоставщика(стрКонтрагент, стрНоменклатураПоставщика, КаталогНастроек, Ини) Экспорт
// Функция сопоставляет любую номенклатуру поставщика с одной единственной номенклатурой нашей организации по коду
	Возврат НайтиНоменклатуруПоставщикаНаСервере(Ини.Конфигурация);	 
КонецФункции
&НаСервереБезКонтекста
Функция НайтиНоменклатуруПоставщикаНаСервере(ИниКонфигурация) Экспорт
// Функция сопоставляет любую номенклатуру поставщика с одной единственной номенклатурой нашей организации по коду

	Результат = Новый Структура("Номенклатура, Характеристика");
	Если Не ИниКонфигурация.Свойство("СуммовойУчетКодНоменклатуры") Тогда
		Возврат Неопределено;	
	КонецЕсли;
	КодНоменклатуры = СтрЗаменить(ИниКонфигурация.СуммовойУчетКодНоменклатуры.Значение,"'","");
	
	Если КодНоменклатуры <> "" Тогда
		НайденнаяСсылка = Справочники.Номенклатура.НайтиПоКоду(КодНоменклатуры);
		Результат.Номенклатура = НайденнаяСсылка;
		Возврат Результат;
	Иначе 
		Возврат Неопределено;
	КонецЕсли;
	 
КонецФункции
&НаКлиенте
Процедура УстановитьСоответствиеНоменклатуры(стрКонтрагент, стрНоменклатураПоставщика, КаталогНастроек, Ини) Экспорт
// Процедура упразднена, т.к. сопоставление не ведется 	

КонецПроцедуры
&НаКлиенте
Функция ПолучитьИдентификаторНоменклатурыПоставщика(стрКонтрагент, стрНоменклатура, КаталогНастроек, Ини) Экспорт
// Процедура упразднена, т.к. сопоставление не ведется	
	Возврат "";
КонецФункции   
&НаКлиенте
Функция сбисПолучитьРеквизитНоменклатурыПоставщика(стрКонтрагент, стрНоменклатура, ИмяРеквизита, КаталогНастроек, Ини) Экспорт
// Процедура упразднена, т.к. сопоставление не ведется	
	Возврат "";
КонецФункции