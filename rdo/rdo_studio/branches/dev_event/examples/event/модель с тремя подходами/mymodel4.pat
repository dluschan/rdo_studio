$Pattern �������_�������_�������: event trace
$Relevant_resources
	_��������������: �������������� Keep
$Body
_��������������
	Convert_event
		�������_�������_�������.Planning(Time_now + ��������_�������(30));
		if (���������_����������� == �������� and ����������_�_������� == 0)
		{
			���������_����������� = �����;
		}
		else
		{
			����������_�_������� += 1;
		}
$End

$Pattern �������_������������_������� : operation trace
$Relevant_resources
	_��������������: �������������� Keep Keep
$Time = ������������_������������( 20, 40 )
$Body
_��������������
	Choice from _��������������.���������_����������� = �������� and _��������������.����������_�_������� > 0
	Convert_begin
		����������_�_������� -= 1;
		���������_����������� = �����;
	Convert_end
		���������_�����������  = ��������;
		����������_����������� += 1;
$End
