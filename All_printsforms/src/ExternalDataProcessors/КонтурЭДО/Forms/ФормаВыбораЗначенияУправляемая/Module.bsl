
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтаФорма.Заголовок							= Параметры.ЗаголовокФормы;
	Элементы.ПолеВводаЗначения.ОграничениеТипа	= Параметры.ТипПоляВвода;
	Элементы.ТекстСообщения.Заголовок			= Параметры.ТекстСообщения;
	Элементы.НадписьПолеВвода.Заголовок			= Параметры.ТекстЗаголовкаПоляВвода;
	Элементы.КнопкаВыполнить.Заголовок			= Параметры.ТекстКнопкиВыполнить;
	
КонецПроцедуры

&НаКлиенте
Процедура КнопкаВыполнить(Команда)
	Закрыть(ПолеВводаЗначения);
КонецПроцедуры



