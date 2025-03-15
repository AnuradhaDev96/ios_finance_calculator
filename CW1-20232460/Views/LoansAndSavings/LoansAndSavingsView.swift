//
//  LoansAndSavingsView.swift
//  CW1-20232460
//
//  Created by Anuradha Hewa Siribaddana on 2025-03-13.
//

import SwiftUI

struct LoansAndSavingsView: View {
    @StateObject private var expectedResult: ResultSelectionViewModel = ResultSelectionViewModel()
    @StateObject private var result: SimpleInterestResultViewModel = SimpleInterestResultViewModel(calculationService: CalculationService())
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("What do you need to calculate?")) {
                    ResultSelectionChips(selectedValue: expectedResult)
                        .listRowBackground(Color.clear)
                }
                switch(expectedResult.selectedResultType) {
                case .simple:
                    SimpleInterestView(result: result)
                case .compound:
                    SimpleInterestView(result: result)
                }
                ResultContainer(title: expectedResult.selectedResultType.rawValue, result: result)
            }
            .navigationBarTitleDisplayMode(.inline) // Makes title smaller
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Loans and Savings")
                        .font(.system(size: 18, weight: .bold)) // Reduce font size to fit width
                        .lineLimit(1) // Ensure it's in one line
                        .minimumScaleFactor(0.7) // Adjusts font size dynamically if needed
                }
            }
        }
    }
}

enum ResultType: String, CaseIterable, Identifiable {
    case simple = "Simple Interest"
    case compound = "Compound Interest"
    
    var id: String {self.rawValue}
}

//class ResultTypeClass: Identifiable {
//    let id = UUID()
//    let rowValue: String = ""
//    @State var isSelected: Bool = false
//}

#Preview {
    LoansAndSavingsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
