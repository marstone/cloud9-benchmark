# patch cloud9 on CentOS 6.3 

CLOUD9_ROOT=/opt/cloud9/src/cloud9


echo "Patching $CLOUD9_ROOT/tools/cloud9-worker/Makefile..."
sed -i 's/lboost_thread-mt/lboost_thread/g' $CLOUD9_ROOT/tools/cloud9-worker/Makefile
sed -i 's/lboost_system-mt/lboost_system/g' $CLOUD9_ROOT/tools/cloud9-worker/Makefile
sed -i 's/lcrypto++/lcryptopp/g' $CLOUD9_ROOT/tools/cloud9-worker/Makefile


echo "Patching $CLOUD9_ROOT/tools/cloud9-lb/Makefile..."
sed -i 's/lboost_thread-mt/lboost_thread/g' $CLOUD9_ROOT/tools/cloud9-lb/Makefile
sed -i 's/lboost_system-mt/lboost_system/g' $CLOUD9_ROOT/tools/cloud9-lb/Makefile

echo "Patching $CLOUD9_ROOT/tools/klee/Makefile..."
sed -i 's/lboost_thread-mt/lboost_thread/g' $CLOUD9_ROOT/tools/klee/Makefile
sed -i 's/lboost_system-mt/lboost_system/g' $CLOUD9_ROOT/tools/klee/Makefile
sed -i 's/lcrypto++/lcryptopp/g' $CLOUD9_ROOT/tools/klee/Makefile

echo "Patching $CLOUD9_ROOT/tools/kleaver/Makefile..."
sed -i 's/lboost_thread-mt/lboost_thread/g' $CLOUD9_ROOT/tools/kleaver/Makefile
sed -i 's/lboost_system-mt/lboost_system/g' $CLOUD9_ROOT/tools/kleaver/Makefile
sed -i 's/lcrypto++/lcryptopp/g' $CLOUD9_ROOT/tools/kleaver/Makefile

echo "Patching $CLOUD9_ROOT/runtime/POSIX/sockets.c..."
#sed -i '1921s/int flags/unsigned int flags/g' $CLOUD9_ROOT/../../sockets.c
sed -i '1921s/int flags/unsigned int flags/g' $CLOUD9_ROOT/runtime/POSIX/sockets.c

echo "Patching $CLOUD9_ROOT/lib/Core/ExecutionState.cpp..."
sed -i 's/<crypto++/<cryptopp/g' $CLOUD9_ROOT/lib/Core/ExecutionState.cpp



