$Sequence ��������_����������� : real
$Type = exponential 123456789
$End

$Sequence ��������������_������ : such_as ������.����������
$Type = by_hist 123456789
$Body
	��_�������_�������     1
	������_�������_������� 1
$End

$Sequence ������������_�������_������ : real [0.0..1.0]
$Type = normal 123456789
$End

$Sequence ������������_���������������_������ : real [0.0..1.0]
$Type = normal 123456789
$End

$Sequence ������������_��������_������ : real [0.0..1.0]
$Type = normal 123456789
$End

$Sequence ������������_��������������_������_��_��������_������� : real [0.15..0.25]
$Type = normal 123456789
$End

$Function ������������_��������������_������_��_�������_������� : real = 0
$Type = algorithmic
$Parameters
	����������_������ : such_as ������.����������
$Body
	if ����������_������ = ��_�������_�������     result = ������������_��������������_������_��_��������_�������( 0.15, 0.25 )
	if ����������_������ = ������_�������_������� result = ������������_��������������_������_��_��������_�������( 0.15, 0.25 )
															+ ������������_��������������_������_��_��������_�������( 0.15, 0.25 )
															+ ������������_��������������_������_��_��������_�������( 0.15, 0.25 )
$End

$Function ������������_��������������_������_������_�������_������� : real = 0
$Type = algorithmic
$Parameters
	����������_������ : such_as ������.����������
$Body
	if ����������_������ = ������_�������_������� result = ������������_��������������_������_��_��������_�������( 0.15, 0.25 )
	if ����������_������ = ��_�������_�������     result = ������������_��������������_������_��_��������_�������( 0.15, 0.25 )
															+ ������������_��������������_������_��_��������_�������( 0.15, 0.25 )
															+ ������������_��������������_������_��_��������_�������( 0.15, 0.25 )
$End

$Function ������������_��������������_������ : real = 0
$Type = algorithmic
$Parameters
	�����������_�������� : such_as ������.����������
	����������_������    : such_as ������.����������
$Body
	if �����������_�������� = ��_�������_�������     result = ������������_��������������_������_��_�������_�������( ����������_������ )
	if �����������_�������� = ������_�������_������� result = ������������_��������������_������_������_�������_�������( ����������_������ )
$End

$Function ���_�������������_������ : real = 0
$Type = algorithmic
$Parameters
	����������_������    : such_as ������.����������
$Body
	if ����������_������ = ������_�������_������� result = 1
	if ����������_������ = ��_�������_�������     result = 0
$End