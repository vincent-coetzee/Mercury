//
//  PickerViewController.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import UIKit

internal class CountriesViewModel: NSObject
    {
    private let countryModel: CountryModel
    
    init(countryModel: CountryModel)
        {
        self.countryModel = countryModel
        }
        
    internal func configure(view: UIPickerView)
        {
        view.dataSource = self
        view.delegate = self
        view.reloadComponent(0)
        }
    }
    
extension CountriesViewModel: UIPickerViewDelegate
    {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {
        return(self.countryModel.countries[row].name)
        }
    }
    
extension CountriesViewModel: UIPickerViewDataSource
    {
    func numberOfComponents(in pickerView: UIPickerView) -> Int
        {
        1
        }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
        {
        self.countryModel.countries.count
        }
    }
    
class CountryPickerViewController: UIViewController
    {
    @IBOutlet var countryPicker: UIPickerView!

    private var countriesViewModel: CountriesViewModel!
    
    internal var countryModel: CountryModel!
        {
        didSet
            {
            self.initViewModels()
            }
        }
    
    override func viewDidLoad()
        {
        super.viewDidLoad()
        if let sheetController = self.presentationController as? UISheetPresentationController
            {
            sheetController.detents = [.medium()]
            sheetController.prefersGrabberVisible = false
            sheetController.preferredCornerRadius = 20
            }
        }
        
    private func initViewModels()
        {
        self.countriesViewModel = CountriesViewModel(countryModel: countryModel)
        self.countriesViewModel.configure(view: self.countryPicker)
        }
    }
