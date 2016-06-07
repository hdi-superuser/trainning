uses crt;
var   n, k: longint;
      i, j: longint;
  nd1, nd2: longint;
     nf, x: longint;
    p1, p2: longint;
      a, f: array[1..1000] of longint;
    idx, c: array[0..65537] of longint;
    d1, d2: array[0..2, 0..65537] of longint;

procedure Quicksort(L, R: longint);
 var i, j, mid, temp: longint;
 begin
	mid := a[(L+R) div 2];
	i := L;	j := R;
	repeat
		while (a[i] < mid) do inc(i);
		while (a[j] > mid) do dec(j);
		if (i <= j) then
		 begin
			temp := a[i];
			a[i] := a[j];
			a[j] := temp;
                        temp := idx[i];
                        idx[i] := idx[j];
                        idx[j] := temp;
			dec(j);	inc(i);
		 end;
	until i > j;
	if (L < j) then Quicksort(L, j);
	if (R > i) then Quicksort(i, R);
 end;

function lower_bound(t: longint): longint;
 var l, r, mid: longint;
 begin
	l := 0;	r := nd1;
	while (l <= r) do
  	  begin
		mid := (l + r) shr 1;
		if (c[mid] = t) then exit(mid);
		if (c[mid] > t) then r := mid - 1 else l := mid + 1;
	  end;
	exit(-1);
 end;

function upper_bound(t: longint): longint;
 var l, r, mid, res: longint;
 begin
	l := 0;	r := nd1; res := -1;
	while (l < r) do
  	  begin
		mid := (l + r) shr 1;
		if (c[mid] > t) then begin r := mid - 1; res := mid; end
		else l := mid + 1;
	  end;
	exit(res);
 end;

procedure print(k1, k2: longint);
 var t: longint;
 begin
        write(k1, ' ', k2, ': ');
	for t := 1 to n div 2 do
		if (k1 shr (t-1)) and 1 = 1 then write(a[t], ' ');
	for t := 1 to nf do
		if (k2 shr (t-1)) and 1 = 1 then write(f[t], ' ');
	writeln;
 end;

BEGIN
        assign(input, 'in.txt');        reset(input);
        assign(output, '');      rewrite(output);
        readln(n, k);
	for i := 1 to n do read(a[i]);
        close(input);
	nd1 := 1 shl (n div 2);	dec(nd1);
	for i := 0 to nd1 do
          begin
                idx[i] := i;
		for j := 1 to n div 2 do
			if (i shr (j-1)) and 1 = 1 then
				inc(c[i], a[j]);
	  end;
	Quicksort(0, nd1);
        for i := 0 to nd1 do write(c[i], ' '); writeln;
	for i := (n div 2) + 1 to n do begin inc(nf); f[nf] := a[i]; end;
	nd2 := (1 shl nf) - 1;
	for i := 0 to nd2 do
  	  begin
		x := 0;
		for j := 1 to nf do
			if (i shr (j-1)) and 1 = 1 then inc (x, f[j]);
                writeln(i, ': ', x, ' ');
		if (x > k) then continue;
		p1 := lower_bound(k - x);
                if (p1 = -1) then continue;
		x := c[p1];
		while (c[p1] = x) do begin print(idx[p1], i); inc(p1); end;
	  end;
        close(output);
END.
