FROM haskell

RUN apt-get update
RUN apt-get install -y build-essential git sudo libncurses5-dev

WORKDIR /
RUN git clone http://www.github.com/gibiansky/IHaskell
WORKDIR /IHaskell

RUN ./root-deps.sh
RUN rm -rf /root/.cabal
RUN cabal update
RUN cabal install happy alex
RUN cabal install cpphs
RUN cabal install gtk2hs-buildtools

RUN ./build.sh all

RUN ihaskell install
ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD /run.sh
