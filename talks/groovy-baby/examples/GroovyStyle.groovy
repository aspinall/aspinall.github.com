myList = [1,2,3,4,5]

List.metaClass.pickOne = {
    delegate[new Random().nextInt(delegate.size())]
}

myList.pickOne()