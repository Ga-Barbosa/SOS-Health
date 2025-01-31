//
//  HomeView.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 14/11/21.
//

import Combine
import SwiftUI
import AlertToast

struct HomeView: View {

    // MARK: Properties

    let rows = [
        GridItem(.flexible())
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject private var coordinator: HomeCoordinator.Router
    @State var cancellable: AnyCancellable?
    @State var sessionProcessingQueue = DispatchQueue(label: "HomeViewQueue")
    @State var fullName: String = ""
    @State var isProfileImage: Bool = false
    @State var profileImage = UIImage()

    @State var contacts = [Contact]()
    @State var careUnits = [CareUnits]()

    @State var emptyCareUnits: Bool = true
    @State var emptyContacts: Bool = true
    @State var sendEvent: Bool = false
    @State var lastSendEvent: ResultSendEvent = .init(isSuccess: true, event: .asthma)

    // MARK: Initializers

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        UIScrollView.appearance().bounces = false
    }

    // MARK: Methods

    func handleViewModel(from state: ViewModel.State) {
        switch state {
        case let .updateUserName(name):
            fullName = name
        case let .updateUserPhoto(image):
            isProfileImage = true
            profileImage = image
        case let .updateUserContacts(contacts):
            self.contacts = contacts ?? [Contact]()
            emptyContacts = contacts == nil || contacts?.isEmpty == true
        case let .updateUserCareUnits(units):
            self.careUnits = units ?? [CareUnits]()
            emptyCareUnits = units == nil || units?.isEmpty == true
        case let .updateSendEvent(result):
            lastSendEvent = result
            sendEvent = true
        default:
            break
        }
    }

    // MARK: Body view

    var body: some View {
        GeometryReader { reader in
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.primary)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: reader.size.height * 0.14,
                            maxHeight: reader.size.height * 0.14,
                            alignment: .center
                        ).cornerRadius(0)
                    Text("Bem vindo, \(fullName)")
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: reader.size.height * 0.125 / 2, leading: 28, bottom: 0, trailing: 28))
                    HStack {
                        if !isProfileImage {
                            Image("avatar")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        } else {
                            Image(uiImage: profileImage)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(EdgeInsets(top: reader.size.height * 0.11 / 2, leading: 0, bottom: 0, trailing: 28))
                }
                ScrollView {
                    VStack(spacing: 24) {
                        if !emptyContacts {
                            Text("Contatos")
                                .foregroundColor(Color.primary)
                                .font(.headline)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: rows, alignment: .center) {
                                    ForEach(contacts, id: \.self) { item in
                                        ContactCardView(name: item.name, phoneNumber: item.phoneNumber.format(with: "(XX) XXXXX-XXXX"))
                                    }
                                }
                                .frame(height: 120)
                                .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 0))
                            }
                        }
                        Text("Solicitações de emergência")
                            .foregroundColor(Color.primary)
                            .font(.headline)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(EmergencyAction.allCases, id: \.self) { item in
                                EmergencyCardView(
                                    name: item.title,
                                    image: item.icon,
                                    color: item.color,
                                    clossure: { 
                                        viewModel.requestEvent(from: item)
                                    }
                                ).frame(minWidth: reader.size.width / 3 - (28 * 2), minHeight: reader.size.height * 0.125)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 216)
                        .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
                        if !emptyCareUnits {
                            Text("Unidades de atendimento próximas")
                                .foregroundColor(Color.primary)
                                .font(.headline)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: rows, alignment: .center) {
                                    ForEach(careUnits, id: \.self) { item in
                                        EmergencyCareUnitView(
                                            image: item.urlImage,
                                            name: item.name,
                                            address: item.address
//                                            distance: item.distance
                                        ).frame(minWidth: 200, maxHeight: .infinity)
                                    }
                                }
                                .frame(height: 308)
                                .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 0))
                            }
                        }
                    }.padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            cancellable = viewModel.$state
                .subscribe(on: sessionProcessingQueue)
                .receive(on: DispatchQueue.main)
                .sink { state in
                    self.handleViewModel(from: state)
                }
            viewModel.loadView()
        }.onDisappear {
            self.cancellable?.cancel()
        }.toast(
            isPresenting: $sendEvent,
            duration: 5,
            tapToDismiss: true,
            alert: {
                AlertToast(
                    type: lastSendEvent.isSuccess ? .complete(.green) : .error(.red),
                    title: lastSendEvent.event.title,
                    subTitle: lastSendEvent.isSuccess ? "Enviado com sucesso" : "Falhou, envie novamente"
                )
            }
        )
    }
}

extension HomeView {

    class ViewModel: ObservableObject {
        // MARK: - Additional states

        enum State {
            case updateUserName(String)
            case updateUserPhoto(UIImage)
            case updateUserContacts([Contact]?)
            case updateUserCareUnits([CareUnits]?)
            case updateSendEvent(ResultSendEvent)
            case `default`
        }

        @Published var state: State = .default

        let getContactsUseCase = GetContactsUseCase(repo: ContactRepositoryImpl(dataSource: ContactDBImpl()))
        let getEmergencyCareUnitsUseCase = GetEmergencyCareUnitsUseCase(repo: EmergencyCareRepositoryImpl(dataSource: EmergencyCareDBImpl()))
        let requestEmergencyUseCase = RequestEmergencyUseCase(repo: RequestEmergencyRepositoryImpl(dataSource: RequestEmergencyDBImpl()))

        func loadView() {
            fetchUserName()
            fetchContacts()
            fetchCareUnits()
            fetchProfileImage()
        }

        func fetchUserName() {
            guard let user = Preferences.shared.user else { return }
            let fullName = user.fullName
            var components = fullName?.components(separatedBy: " ")
            if !(components?.isEmpty ?? true) {
                let firstName = components?.removeFirst()
                state = .updateUserName(firstName ?? "")
            }
        }

        func fetchCareUnits() {
            Task {
                let result = await getEmergencyCareUnitsUseCase.execute()
                state = .updateUserCareUnits(result)
            }
        }

        func fetchContacts() {
            guard let uid = Preferences.shared.firebaseUser?.uid else { return }
            Task {
                let contacts = await getContactsUseCase.execute(uid: uid)
                self.state = .updateUserContacts(contacts)
            }
        }

        func requestEvent(from event: EmergencyAction) {
            Task {
                let result = await requestEmergencyUseCase.execute(event: event)
                state = .updateSendEvent(.init(isSuccess: result, event: event))
            }
        }

        func fetchProfileImage() {
            guard let firebaseUser = Preferences.shared.firebaseUser,
                  let photoURL = firebaseUser.photoURL else { return }
            let task = URLSession.shared.dataTask(with: photoURL) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.state = .updateUserPhoto(image)
                }
            }
            task.resume()
        }
    }
}
