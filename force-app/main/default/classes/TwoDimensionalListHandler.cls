public class TwoDimensionalListHandler {
    private List<List<Integer>> twoDimensionalList;

    public TwoDimensionalListHandler(List<List<Integer>> inputList) {
        this.twoDimensionalList = inputList;
    }

    // Function to transpose the values in the 2-D list
    public void transpose() {
        List<List<Integer>> transposedList = new List<List<Integer>>();
        for (Integer i = 0; i < twoDimensionalList[0].size(); i++) {
            List<Integer> newRow = new List<Integer>();
            for (Integer j = 0; j < twoDimensionalList.size(); j++) {
                newRow.add(twoDimensionalList[j][i]);
            }
            transposedList.add(newRow);
        }
        twoDimensionalList = transposedList;
    }

    // Function to put all the values in the 2-D list into a map
    public Map<Integer, List<Integer>> convertToListMap() {
        Map<Integer, List<Integer>> mapList = new Map<Integer, List<Integer>>();
        for (Integer i = 0; i < twoDimensionalList.size(); i++) {
            mapList.put(i, twoDimensionalList[i]);
        }
        return mapList;
    }
}