$Pattern �������_�����������_�����_������ : irregular_event trace
$Relevant_resources
	_�������       : �������  Keep
	_������        : ������   Create
$Time = ��������_�����������( 1.5 )
$Body
_�������
	Convert_event
		����������_���������_������� set _�������.����������_���������_������� + 1
		�������_�����_������� set _�������.�������_�����_������� + 1

_������
	Convert_event
		�����                set _�������.����������_���������_�������
		����������           set ��������������_������
		���������            set ��������
$End

$Pattern �������_�������_������_������� : operation trace
$Relevant_resources
	_�������  : �������  Keep Keep
	_������   : ������   Keep Keep
	_�����    : �����    Keep Keep
$Time = ������������_�������_������( 0.2, 0.02 )
$Body
_�������
	Choice from _�������.�������_�����_������� > 0
	Convert_begin
		�������_�����_�������  set _�������.�������_�����_������� - 1
	Convert_end
		���_��������������_�������_������  set _������.����������

_������
	Choice from _������.��������� = ��������
	with_min( _������.����� )
	Convert_begin
		���������  set ������_�����
	Convert_end
		���������  set ������_��������

_�����
	Choice from _�����.��������� = ��������
	Convert_begin
		���������  set ������_�����
	Convert_end
		���������  set ������_��������
$End

$Pattern �������_��������������_������ : operation trace
$Parameters �����������_�������� : such_as ������.����������
$Relevant_resources
	_������   : ������   Keep Keep
	_�����    : �����    Keep Keep
$Time = ������������_��������������_������( �����������_��������, _������.���������� )
$Body
_������
	Choice from _������.��������� = ������_��������
	Convert_begin
		���������  set ��������������_������
	Convert_end
		���������  set ��������������_���������

_�����
	Choice from _�����.��������� = ������_��������
	Convert_begin
		���������  set ��������������_������
	Convert_end
		���������  set ��������������_���������
$End

$Pattern �������_���������������_������_������� : operation trace
$Relevant_resources
	_�������  : �������  NoChange Keep
	_������   : ������   Keep     Keep
	_�����    : �����    Keep     Keep
$Time = ������������_���������������_������( 0.4, 0.04 )
$Body
_�������
	Convert_end
		����������_�����������_������� set _�������.����������_�����������_������� + 1
_������
	Choice from _������.��������� = ��������������_���������
	Convert_begin
		���������  set ���������������_������
	Convert_end
		���������  set ���������������_���������

_�����
	Choice from _�����.��������� = ��������������_���������
	Convert_begin
		���������  set ���������������_������
	Convert_end
		���������  set ���������������_���������
$End

$Pattern �������_��������_������ : operation trace
$Relevant_resources
	_�����    : �����    Keep Keep
$Time = ������������_��������_������( 0.4, 0.04 )
$Body
_�����
	Choice from _�����.��������� = ���������������_���������
	Convert_begin
		���������  set �������
	Convert_end
		���������  set ��������
$End