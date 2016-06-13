#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;
typedef long long ll;

int N, M;
vi primes;
bitset<30001> bs;

void _sieve(int upperbound) {
    bs.set();
    bs[0] = bs[1] = 0;
    for (int i = 2; i <= upperbound; i++)
        if (bs[i]) {
            for (int j = i*i; j <= upperbound; j += i)
                bs[j] = 0;
            primes.push_back(i);
        }
}

vi primesFactor(int x) {
    vi factor;
    factor.assign(30000, 0);
    int MAX;
    for (int i = 0; i <= primes.size(); i++)
        while (x % primes[i] == 0) {
            MAX = primes[i];
            x /= primes[i];
            factor[primes[i]]++;
            if (x == 0) return factor;
        }
    if (N != 1) factor[N]++, MAX = N;
    factor[0] = MAX;
    return factor;
}

int main() {
    freopen("in.txt", "r", stdin);
    scanf("%d %d", &N, &M);
    _sieve(30000);
    //vi fac_N = primesFactor(N);
    //vi fac_M = primesFactor(M);
    vi fac_NM = primesFactor(4);
    return 0;
    int cnt = 0;
    //for (int i = 1; i <= fac_N[0]; i++)
    //    if (fac_N[i] - fac_M[i] - fac_NM[i] > 0) cnt++;
    printf("%d\n", cnt);
}
