module m {
    require "cf.h";

    use IO;

    extern proc openTestFile(): _file;

    try! {
        var f = openfp(openTestFile(), hints = ioHintSet.fromFlag(QIO_HINT_OWNED));
        f.close();

        f = openfp(openTestFile(), hints = ioHintSet.fromFlag(QIO_HINT_OWNED), style = new iostyle());
        f.close();
    }
}
