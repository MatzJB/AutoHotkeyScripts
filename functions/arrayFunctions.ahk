; misc array functions

len(arr)
{
	index := 0
	for key,value in arr
		index+=1

	return index
}


compareArrays(a1, a2)
{
	if len(a1)!=len(a2)
		return False

	for key,value in a1
		if a1[key] != a2[key]
		return False
	return True
}


roundArray(a1)
{
	ret := []
	for key,value in a1
		ret[key] := Floor( a1[key] )
	return ret
}