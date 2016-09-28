#pragma once


#include <Core/Core.h>

namespace PixelLight
{
	/**
	 *	De-reference a type
	 */
	template <class T>
	struct RemoveRef
	{
		typedef T Type;
	};

	template <class T>
	struct RemoveRef<T&>
	{
		typedef T Type;
	};

	template <class T>
	struct RemoveRef<T&&>
	{
		typedef T Type;
	};

	template <class T>
	using RemoveRefT = typename RemoveRef<T>::Type;

	/**
	 *	De-const a type
	 */
	template <class T>
	struct RemoveConst
	{
		typedef T Type;
	};

	template <class T>
	struct RemoveConst<const T>
	{
		typedef T Type;
	};

	template <class T>
	using RemoveConstT = typename RemoveConst<T>::Type;

	/**
	*	De-volatile a type
	*/
	template <class T>
	struct RemoveVolatile
	{
		typedef T Type;
	};

	template <class T>
	struct RemoveVolatile<volatile T>
	{
		typedef T Type;
	};

	template <class T>
	using RemoveVolatileT = typename RemoveVolatile<T>::Type;

	/**
	 *	Combination of RemoveConst and RemoveVolatile
	 */
	template <class T>
	struct RemoveCV
	{
		typedef RemoveVolatileT<RemoveConstT<T>> Type;
	};

	template <class T>
	using RemoveCVT = typename RemoveCV<T>::Type;

	/**
	 *	Get base type of an array
	 */
	template <class T>
	struct RemoveExtent
	{
		typedef T Type;
	};

	template <class T>
	struct RemoveExtent<T[]>
	{
		typedef T Type;
	};

	PL_TODO(AM, "Should use size_t equivalent");
	template <class T, int N>
	struct RemoveExtent<T[N]>
	{
		typedef T Type;
	};

	template <class T>
	using RemoveExtentT = typename RemoveExtent<T>::Type;

	/**
	 *	Compile type conditional
	 */
	template <bool B, class TrueT, class FalseT>
	struct StaticIf
	{
		typedef TrueT Type;
	};

	template <class TrueT, class FalseT>
	struct StaticIf<false, TrueT, FalseT>
	{
		typedef FalseT Type;
	};

	template <bool B, class TrueT, class FalseT>
	using StaticIfT = typename StaticIf<B, TrueT, FalseT>::Type;

	/**
	 *	Compile-time constant
	 */
	template <class T, T Val>
	struct StaticConst
	{
		static constexpr T Value = Val;

		typedef T ValueType;
		typedef StaticConst Type;
	};

	typedef StaticConst<bool, true> StaticTrue;
	typedef StaticConst<bool, false> StaticFalse;

	/**
	*	Check if given type is an array
	*/
	template <class T>
	struct IsArray : StaticFalse {};

	template <class T>
	struct IsArray<T[]> : StaticTrue {};

	PL_TODO(AM, "Should use size_t equivalent");
	template <class T, int N>
	struct IsArray<T[N]> : StaticTrue {};

	template <class T>
	constexpr bool IsArrayV = IsArray<T>::Value;

	/**
	 *	Check if given type is a function
	 */
	template<class>
	struct IsFunction : StaticFalse {};

	// Specialization for regular functions
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)> : StaticTrue {};

	// Specialization for variadic functions such as std::printf
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)> : StaticTrue {};

	// specialization for function types that have cv-qualifiers
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)const> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)volatile> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)const volatile> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)const> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)volatile> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)const volatile> : StaticTrue {};

	// Specialization for function types that have ref-qualifiers
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...) &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)const &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)volatile &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)const volatile &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...) &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)const &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)volatile &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)const volatile &> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...) && > : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)const &&> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)volatile &&> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args...)const volatile &&> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...) && > : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)const &&> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)volatile &&> : StaticTrue {};
	template<class Ret, class... Args>
	struct IsFunction<Ret(Args..., ...)const volatile &&> : StaticTrue {};

	template <class T>
	constexpr bool IsFunctionV = IsFunction<T>::Value;

	/**
	 *	Check if given type is a function pointer
	 */
	template<class>
	struct IsFunctionPtr : StaticFalse {};

	// Specialization for regular functions
	template<class Ret, class... Args>
	struct IsFunctionPtr<Ret(*)(Args...)> : StaticTrue {};

	// Specialization for variadic functions such as std::printf
	template<class Ret, class... Args>
	struct IsFunctionPtr<Ret(*)(Args..., ...)> : StaticTrue {};

	template <class T>
	constexpr bool IsFunctionPtrV = IsFunction<T>::Value;

	/**
	 *	Attach a pointer to type
	 */
	namespace Internal
	{
		template <class T, bool IsFunction = false>
		struct AddPointer
		{
			using Type = RemoveRefT<T>*;
		};

		template <class T>
		struct AddPointer<T, true>
		{
			using Type = T;
		};

		template <class T, class... Args>
		struct AddPointer<T(Args...), true>
		{
			using Type = T(*)(Args...);
		};

		template <class T, class... Args>
		struct AddPointer<T(Args..., ...), true>
		{
			using Type = T(*)(Args..., ...);
		};
	}

	template <class T>
	struct AddPointer : Internal::AddPointer<T, IsFunctionV<T>> {};

	template <class T>
	using AddPointerT = typename AddPointer<T>::Type;

	/**
	 *	Apply implicit conversion to a type
	 *	Basically the same as what would happen if T was passed into a function by value
	 */
	template <class T>
	struct Decay
	{
	private:
		typedef RemoveRefT<T> U;

	public:
		typedef StaticIfT<
			IsArrayV<U>,
			RemoveExtentT<U>,
			StaticIfT<IsFunctionV<U>, AddPointerT<U>, RemoveCVT<U>>
		> Type;
	};

	template <class T>
	using DecayT = typename Decay<T>::Type;
}
